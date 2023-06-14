require "google/apis/calendar_v3"
require "google/api_client/client_secrets.rb"
require 'active_support/time'
require 'json'

class BookingsController < ApplicationController
  before_action :authenticate_user!, except: [:choose_reservation, :landing_reservation, :finish_reservation, :create]

  before_action :check_onboarding_status, except: [:choose_reservation, :landing_reservation, :finish_reservation, :create]

  def check_onboarding_status
    if current_user && !current_user.step_1
      redirect_to onboarding_path(step: 'step1')
    elsif current_user && !current_user.step_2
      redirect_to onboarding_path(step: 'step2')
    elsif current_user && !current_user.step_3
      redirect_to onboarding_path(step: 'step3')
    elsif current_user && !current_user.step_4
      redirect_to onboarding_path(step: 'step4')
    end
  end

  CALENDAR_ID = 'primary'


  def landing_reservation
    @user = User.find_by(token: reservation_params[:token])
    @formules = @user.formules
    @tags = @user.tags
  end

  def choose_reservation
    @user = User.find_by(token: reservation_params[:token])
    @formule = Formule.find(reservation_params[:formule_id])
    interval = @formule.duration
    slot_duration = @formule.duration
    start_time = Time.zone.parse(@user.daily_start_time)
    end_time = Time.zone.parse(@user.daily_end_time) - slot_duration
    days_of_week = @user.days_of_week
    num_weeks = 4
    if @user.excluded_fixed_weekly_slots.is_a?(String)
      excluded_fixed_weekly_slots = JSON.parse(@user.excluded_fixed_weekly_slots)
    else
      excluded_fixed_weekly_slots = @user.excluded_fixed_weekly_slots
    end
    @user_bookings = @user.bookings.upcoming_all
    # Generate the available datetimes using the generate_datetimes function
    full_datetimes = generate_datetimes(start_time, end_time, interval, num_weeks, slot_duration, excluded_fixed_weekly_slots, @user)
    @full_datetimes = full_datetimes
  end

  def finish_reservation
    @user = User.find_by(token: reservation_params[:token])
    @formule = Formule.find_by(id: reservation_params[:formule].to_i)
    @datetime = reservation_params[:datetime]
    @booking = Booking.new
    @client = Client.new
  end

  def new
    @user = current_user
    @formules = @user.formules
  end

  def new_choose_reservation
    @user = current_user
    @formule = Formule.find(reservation_params[:formule_id])
    interval = @formule.duration
    slot_duration = @formule.duration
    start_time = Time.zone.parse(@user.daily_start_time)
    end_time = Time.zone.parse(@user.daily_end_time) - slot_duration
    days_of_week = @user.days_of_week
    num_weeks = 4
    if current_user.excluded_fixed_weekly_slots.is_a?(String)
      excluded_fixed_weekly_slots = JSON.parse(current_user.excluded_fixed_weekly_slots)
    else
      excluded_fixed_weekly_slots = current_user.excluded_fixed_weekly_slots
    end
    @user_bookings = @user.bookings.upcoming_all
    # Generate the available datetimes using the generate_datetimes function
    full_datetimes = generate_datetimes(start_time, end_time, interval, num_weeks, slot_duration, excluded_fixed_weekly_slots, @user)
    @full_datetimes = full_datetimes
  end

  def new_finish_reservation
    @user = current_user
    @formule = Formule.find_by(id: reservation_params[:formule].to_i)
    @datetime = reservation_params[:datetime]
    @booking = Booking.new
    @client = Client.new
    @clients = @user.clients
  end

  def date_new_reservation
    @user = current_user
    @formules = @user.formules
    @datetime = params[:datetime]
    @jour = params[:jour]
    if @jour
      interval = @user.formules.minimum(:duration)
      slot_duration = @user.formules.minimum(:duration)
      start_time = Time.zone.parse(@user.daily_start_time)
      end_time = Time.zone.parse(@user.daily_end_time) - slot_duration
      days_of_week = @user.days_of_week
      num_weeks = 4
      if current_user.excluded_fixed_weekly_slots.is_a?(String)
        excluded_fixed_weekly_slots = JSON.parse(current_user.excluded_fixed_weekly_slots)
      else
        excluded_fixed_weekly_slots = current_user.excluded_fixed_weekly_slots
      end
      @datetimes = generate_day_datetimes(start_time, end_time, interval, slot_duration, excluded_fixed_weekly_slots, @user, @jour)
    end
  end

  def date_new_finish_reservation
    @user = current_user
    @formule = Formule.find(params[:formule_id])
    if params[:jour]
      @datetime = Time.zone.parse("#{params[:jour]} #{params[:time]}").to_s
    else
      @datetime = params[:datetime]
    end
    @booking = Booking.new
    @client = Client.new
    @clients = @user.clients
  end

  def client_new_reservation
    @user = current_user
    @formules = @user.formules
    @client = Client.find(params[:client_id])
  end

  def client_new_finish_reservation
    @user = current_user
    @formule = Formule.find(params[:formule_id])
    @client = Client.find(params[:client_id])
    interval = @formule.duration
    slot_duration = @formule.duration
    start_time = Time.zone.parse(@user.daily_start_time)
    end_time = Time.zone.parse(@user.daily_end_time) - slot_duration
    days_of_week = @user.days_of_week
    num_weeks = 5
    if @user.excluded_fixed_weekly_slots.is_a?(String)
      excluded_fixed_weekly_slots = JSON.parse(@user.excluded_fixed_weekly_slots)
    else
      excluded_fixed_weekly_slots = @user.excluded_fixed_weekly_slots
    end
    @user_bookings = @user.bookings.upcoming_all
    # Generate the available datetimes using the generate_datetimes function
    full_datetimes = generate_datetimes(start_time, end_time, interval, num_weeks, slot_duration, excluded_fixed_weekly_slots, @user)
    @full_datetimes = full_datetimes
  end

  def client_confirm_reservation
    @user = current_user
    @formule = Formule.find(params[:formule].to_i)
    @client = Client.find(params[:client_id].to_i)
    @datetime = params[:datetime]
    @booking = Booking.new
  end

  def show
    @booking = Booking.find(params[:id])
    @client_data_hash = get_client_data(@booking.client.id)
    @marker = {
      lat: @booking.formule.latitude,
      lng: @booking.formule.longitude,
      info_window_html: render_to_string(partial: "info_window", locals: { booking: @booking })
    }
    @previous_page = params[:format]
    @calendar_bookings = current_user.bookings.where("start_time BETWEEN ? AND ? AND status = 'Accepted'", 2.months.ago, 2.months.from_now)
  end

  def index
    user_bookings = current_user.bookings
    @today_bookings = user_bookings.today
    @tomorrow_bookings = user_bookings.tomorrow
    @this_week_bookings = user_bookings.this_week
    @next_week_bookings = user_bookings.next_week
    @next_bookings = user_bookings.next_bookings
    @next_month_bookings = user_bookings.next_month
    @after_bookings = user_bookings.after
    @passed_bookings = user_bookings.passed_confirmed

    @today_pending_bookings = user_bookings.today_pending
    @tomorrow_pending_bookings = user_bookings.tomorrow_pending
    @this_week_pending_bookings = user_bookings.this_week_pending
    @next_week_pending_bookings = user_bookings.next_week_pending
    @after_pending_bookings = user_bookings.after_pending
  end

  def confirm
    @booking = Booking.find(params[:id])
    @booking.update(status: "Accepted")
    flash[:notice] = "Demande de réservation acceptée !"
    redirect_to bookings_path
    BookingMailer.user_booking_email(@user, @booking).deliver_later
    BookingMailer.client_booking_email(@client, @booking).deliver_later
  end

  def refuse
    @booking = Booking.find(params[:id])
    @booking.update(status: "Refused")
    flash[:notice] = "Demande de réservation refusée !"
    redirect_to bookings_path
    BookingMailer.user_booking_email_refuse(@user, @booking).deliver_later
    BookingMailer.client_booking_email_refuse(@client, @booking).deliver_later
  end

  def create
    if params[:booking][:status] == "Accepted"

      if params[:booking][:origin] == "client_new_finish"
        client_id = params[:booking][:client_id].to_i
        @client = Client.find(client_id)
        @user = current_user
        @booking = Booking.new(client_booking_params)
        @booking.client_id = @client.id
        @booking.user_id = @user.id
        if @booking.save
          flash[:notice] = "Réservation ajoutée !"
          redirect_to root_path
          BookingMailer.user_booking_email(@user, @booking).deliver_now
          BookingMailer.client_booking_email(@client, @booking).deliver_now
        else
          # Handle errors if the booking can't be saved
          flash[:alert] = "Erreur de création réservation"
          redirect_to client_confirm_reservation_path(client_id: params[:client_id], datetime: params[:start_time], formule: params[:formule_id])
        end

      elsif params[:booking][:client].present? && !params[:booking][:client].key?(:first_name)
        client_id = booking_params[:client][:id]
        @client = Client.find(client_id)
        @user = current_user
        @booking = Booking.new(booking_params.except(:client, :back))
        @booking.client_id = @client.id
        @booking.user_id = @user.id
        if @booking.save
          # Handle successful booking creation
          flash[:notice] = "Réservation ajoutée !"
          redirect_to root_path
          BookingMailer.user_booking_email(@user, @booking).deliver_now
          BookingMailer.client_booking_email(@client, @booking).deliver_now
        else
          if params[:booking][:origin] == "date_new_finish"
            # Handle errors if the booking can't be saved
            flash[:alert] = "Erreur de création réservation"
            redirect_to date_new_finish_reservation_path(datetime: params[:booking][:back][:datetime], formule: params[:booking][:back][:formule])
          else
             # Handle errors if the booking can't be saved
             flash[:alert] = "Erreur de création réservation"
             redirect_to new_finish_reservation_path(datetime: params[:booking][:back][:datetime], formule: params[:booking][:back][:formule])
          end
        end
      elsif params[:booking][:client].present? && params[:booking][:client].key?(:first_name)
        @user = current_user
        @booking = Booking.new(booking_params.except(:client, :back))
        @client = Client.new(booking_params[:client])
        @client.user_id = @user.id
        if params[:booking][:client][:photo].present?
          @client.photo.attach(params[:booking][:client][:photo])
        end
        if @client.save
          @booking.client_id = @client.id
          @booking.user_id = @user.id
          if @booking.save!
            # Handle successful booking creation
            flash[:notice] = "Réservation ajoutée !"
            redirect_to root_path
            BookingMailer.user_booking_email(@user, @booking).deliver_later
            BookingMailer.client_booking_email(@client, @booking).deliver_later
          else
            if params[:booking][:origin] == "date_new_finish"
              # Handle errors if the booking can't be saved
              flash[:alert] = "Erreur de création réservation"
              redirect_to date_new_finish_reservation_path(datetime: params[:booking][:back][:datetime], formule: params[:booking][:back][:formule])
            else
               # Handle errors if the booking can't be saved
               flash[:alert] = "Erreur de création réservation"
               redirect_to new_finish_reservation_path(datetime: params[:booking][:back][:datetime], formule: params[:booking][:back][:formule])
            end
          end
        else
          if params[:booking][:origin] == "date_new_finish"
            # Handle errors if the booking can't be saved
            flash[:alert] = "Erreur de création contact client"
            redirect_to date_new_finish_reservation_path(datetime: params[:booking][:back][:datetime], formule: params[:booking][:back][:formule])
          else
             # Handle errors if the booking can't be saved
             flash[:alert] = "Erreur de création contact client"
             redirect_to new_finish_reservation_path(datetime: params[:booking][:back][:datetime], formule: params[:booking][:back][:formule])
          end
        end
      end

    else

      if params[:booking][:client].present? && !params[:booking][:client].key?(:first_name)
        client_email = booking_params[:client][:email]
        @client = Client.find_by(email: client_email)
        @user = User.find(booking_params[:user_id])
        if @client
          @booking = Booking.new(booking_params.except(:client, :back))
          @booking.client_id = @client.id
          @booking.user_id = @user.id
          if @booking.save
            # Handle successful booking creation
            flash[:notice] = "Demande de réservation envoyée !"
            redirect_to landing_reservation_path(@user.token)
            BookingMailer.user_booking_email_pending(@user, @booking).deliver_later
            BookingMailer.client_booking_email_pending(@client, @booking).deliver_later
          else
            # Handle errors if the booking can't be saved
            flash[:alert] = "Erreur de création réservation"
            redirect_to finish_reservation_path(token: @user.token, datetime: params[:booking][:back][:datetime], formule: params[:booking][:back][:formule])
          end
        else
          flash[:alert] = "Adresse email non répertoriée, veuillez effectuer l'inscription"
          redirect_to finish_reservation_path(token: @user.token, datetime: params[:booking][:back][:datetime], formule: params[:booking][:back][:formule])
        end
      elsif params[:booking][:client].present? && params[:booking][:client].key?(:first_name)
        @user = User.find(booking_params[:user_id])
        @booking = Booking.new(booking_params.except(:client, :back))
        @client = Client.new(booking_params[:client])
        @client.user_id = @user.id
        if params[:booking][:client][:photo].present?
          @client.photo.attach(params[:booking][:client][:photo])
        end
        if @client.save
          @booking.client_id = @client.id
          @booking.user_id = @user.id
          if @booking.save!
            # Handle successful booking creation
            flash[:notice] = "Demande de réservation envoyée !"
            redirect_to landing_reservation_path(@user.token)
            BookingMailer.user_booking_email_pending(@user, @booking).deliver_later
            BookingMailer.client_booking_email_pending(@client, @booking).deliver_later
          else
            # Handle errors if the booking can't be saved
            flash[:alert] = "Erreur de création réservation"
            redirect_to finish_reservation_path(token: @user.token, datetime: params[:booking][:back][:datetime], formule: params[:booking][:back][:formule])
          end
        else
          flash[:alert] = "Erreur de création contact client"
          redirect_to finish_reservation_path(token: @user.token, datetime: params[:booking][:back][:datetime], formule: params[:booking][:back][:formule])
        end
      end

    end
  end

  def disponibilites

    # // FOR WEEKLY
    start_date = Date.today.beginning_of_week
    end_date = 6.months.from_now.end_of_week
    @weeks = (start_date..end_date).step(7).to_a
    # // FOR DAILY
    interval = current_user.formules.minimum(:duration)
    @slot_duration = current_user.formules.minimum(:duration)
    start_time = Time.zone.parse(current_user.daily_start_time)
    end_time = Time.zone.parse(current_user.daily_end_time) - @slot_duration
    @days_of_week = current_user.days_of_week
    num_weeks = 4
    if current_user.excluded_fixed_weekly_slots.is_a?(String)
      excluded_fixed_weekly_slots = JSON.parse(current_user.excluded_fixed_weekly_slots)
    else
      excluded_fixed_weekly_slots = current_user.excluded_fixed_weekly_slots
    end
    # Update available datetimes with newly cancelled or added slots
    if params[:cancelled_slot]
      @cancelled_slot = Time.zone.parse(params[:cancelled_slot])
      @weekly_index = params[:weekly_index].to_i
      @daily_index = params[:daily_index].to_i
      available_booking = Available.find_by(start_time: @cancelled_slot, end_time: @cancelled_slot + @slot_duration.minutes)
      if available_booking
        available_booking.destroy
      else
        cancelled_booking = Booking.new(start_time: @cancelled_slot, end_time: @cancelled_slot + @slot_duration.minutes, status:"Accepted", cancel_type: "Cancelled")
        cancelled_booking.user_id = current_user.id
        cancelled_booking.save
      end
    elsif params[:added_slot]
      @weekly_index = params[:added_slot][:weekly_index].to_i
      @daily_index = params[:added_slot][:daily_index].to_i
      date = Time.zone.parse(params[:added_slot][:day])
      time = Time.zone.parse(params[:added_slot][:added_slot])
      datetime = Time.zone.local(date.year, date.month, date.day, time.hour, time.min, time.sec)

      # Check if there's a booking with the same start_time and cancel_type: "Cancelled"
      cancelled_booking = Booking.find_by(start_time: datetime, cancel_type: "Cancelled", user_id: current_user.id)

      if cancelled_booking
        # Destroy the cancelled booking
        cancelled_booking.destroy
      else
        # Create a new availability
        added_slot = Available.new(start_time: datetime, end_time: datetime + @slot_duration.minutes)
        added_slot.user_id = current_user.id
        added_slot.save
      end
    end


    @user_bookings = current_user.bookings.upcoming_all
    # Generate the available datetimes using the generate_datetimes function
    available_datetimes = generate_datetimes(start_time, end_time, interval, num_weeks, @slot_duration, excluded_fixed_weekly_slots)

    @full_datetimes = available_datetimes



    if params[:cancelled_slot]
      puts "Sending Turbo Stream to update daily card..."
      render turbo_stream:
        turbo_stream.replace("daily-card-#{@weekly_index}-#{@daily_index}",
        partial: "bookings/daily_card",
        locals: { daily_datetimes: @full_datetimes[@weekly_index][@daily_index], daily_index: @daily_index, weekly_index: @weekly_index })
    end

  end

  def update_availability
    availability = AvailabilityWeek.find(params[:id])
    availability.update(availability_week_params)
  end

  private

  def reservation_params
    params.permit(:formule_id, :formule, :booking_option, :token, :datetime)
  end

  def booking_params
    params.require(:booking).permit(:start_time, :end_time, :payment_status, :price, :user_id, :booking_type, :message, :formule_id, :status, client: [:email, :first_name, :last_name, :phone_number, :photo, :id], back: [:datetime, :formule])
  end

  def client_booking_params
    params.require(:booking).permit(:start_time, :end_time, :payment_status, :price, :user_id, :booking_type, :message, :formule_id, :status)
  end

  def availability_week_params
    params.require(:availability_week).permit(:week_enabled, :available_monday, :available_tuesday, :available_wednesday, :available_thursday, :available_friday, :available_saturday, :available_sunday)
  end



  def generate_datetimes(start_time, end_time, interval, num_weeks, slot_duration, excluded_fixed_weekly_slots, user = nil)
    Time.zone = 'Europe/Paris'
    full_datetimes = []
    weekly_datetimes = []
    daily_datetimes = []
    current_time = Time.zone.now

    user ||= current_user
    given_days_of_week = user.days_of_week
    converted_available_slots = convert_available_slots(user.availables)
    availability_weeks = user.availability_weeks

    week_num = 0
    while week_num < num_weeks
      formatted_current_week_start = (current_time.beginning_of_week + week_num.weeks).strftime("%a, %d %b %Y")
      availability_week = availability_weeks.find { |aw| aw.week_start.strftime("%a, %d %b %Y") == formatted_current_week_start }

      # Skip the week if it's not enabled
      if availability_week && !availability_week.week_enabled
        # Add an empty weekly_datetimes array to full_datetimes when the week is disabled
        full_datetimes << []
      else
        given_days_of_week.each do |day|
          # Calculate the first day of the week for the current iteration
          next if availability_week && !availability_week["available_#{day.downcase}"]
          # Calculate the first day of the week for the current iteration
          first_day_of_week = current_time.beginning_of_week + week_num.weeks
          # Calculate the target_day based on the first_day_of_week and the current day of the week
          day_offset = (Date.parse(day).wday - first_day_of_week.wday) % 7
          target_day = first_day_of_week + day_offset.days

          # Skip the day if it's not available

          slot = Time.zone.local(target_day.year, target_day.month, target_day.day, start_time.hour, start_time.min, start_time.sec)
          while slot <= Time.zone.local(target_day.year, target_day.month, target_day.day, end_time.hour, end_time.min, end_time.sec)
            excluded = false
            excluded_fixed_weekly_slots.each do |fw_slot|
              fw_day_of_week = fw_slot[0]
              fw_start_time = Time.zone.parse(fw_slot[1])
              fw_end_time = Time.zone.parse(fw_slot[2])
              if slot.strftime("%A") == fw_day_of_week && slot >= Time.zone.local(slot.year, slot.month, slot.day, fw_start_time.hour, fw_start_time.min, 0) && slot + slot_duration.minutes <= Time.zone.local(slot.year, slot.month, slot.day, fw_end_time.hour, fw_end_time.min, 0)
                excluded = true
                break
              end
            end
            daily_datetimes << slot unless excluded || slot.to_date < current_time.to_date
            slot += interval.minutes
          end

          # Add converted_available_slots to the daily_datetimes array before calling sort_bookings
          converted_available_slots.each do |available_slot|
            # target_day = Date.parse(day) + (7 * week_num)
            puts "Checking available_slot: #{available_slot.to_date}, target_day: #{target_day.to_date}, current_time: #{current_time.to_date}"
            if available_slot.to_date == target_day.to_date && available_slot.to_date >= current_time.to_date && !daily_datetimes.include?(available_slot)
              puts "Adding #{available_slot} to daily_datetimes"
              daily_datetimes << available_slot
            end
          end

          daily_datetimes.sort!
          puts "daily_datetimes after sorting: #{daily_datetimes}"

          # Call sort_bookings after adding converted_available_slots
          sort_bookings(daily_datetimes, slot_duration, user)

          weekly_datetimes << daily_datetimes unless daily_datetimes.empty?
          daily_datetimes = []
        end
      end
      full_datetimes << weekly_datetimes
      if weekly_datetimes.empty?
        num_weeks += 1
      end
      weekly_datetimes = []
      week_num += 1
    end

    full_datetimes
  end

  def generate_day_datetimes(start_time, end_time, interval, slot_duration, excluded_fixed_weekly_slots, user = nil, target_date)
    Time.zone = 'Europe/Paris'
    daily_datetimes = []
    current_time = Time.zone.now

    user ||= current_user
    converted_available_slots = convert_available_slots(user.availables)

    target_day = Date.parse(target_date)

    slot = Time.zone.local(target_day.year, target_day.month, target_day.day, start_time.hour, start_time.min, start_time.sec)
    while slot <= Time.zone.local(target_day.year, target_day.month, target_day.day, end_time.hour, end_time.min, end_time.sec)
      excluded = false
      excluded_fixed_weekly_slots.each do |fw_slot|
        fw_day_of_week = fw_slot[0]
        fw_start_time = Time.zone.parse(fw_slot[1])
        fw_end_time = Time.zone.parse(fw_slot[2])
        if slot.strftime("%A") == fw_day_of_week && slot >= Time.zone.local(slot.year, slot.month, slot.day, fw_start_time.hour, fw_start_time.min, 0) && slot + slot_duration.minutes <= Time.zone.local(slot.year, slot.month, slot.day, fw_end_time.hour, fw_end_time.min, 0)
          excluded = true
          break
        end
      end
      daily_datetimes << slot unless excluded || slot.to_date < current_time.to_date
      slot += interval.minutes
    end

    converted_available_slots.each do |available_slot|
      if available_slot.to_date == target_day.to_date && available_slot.to_date >= current_time.to_date && !daily_datetimes.include?(available_slot)
        daily_datetimes << available_slot
      end
    end

    daily_datetimes.sort!
    sort_bookings(daily_datetimes, slot_duration, user)

    daily_datetimes
  end


  def convert_available_slots(available_slots)
    converted_slots = []
    available_slots.each do |slot|
      slot_start = slot.start_time
      converted_slots << slot_start
    end
    converted_slots
  end


  def sort_bookings(daily_datetimes, slot_duration, user)
    @user_bookings = user.bookings.upcoming_all
    overlapping_slots = []
    daily_datetimes.each do |slot|
      slot_end = slot + slot_duration.minutes
      @user_bookings.each do |booking|
        if (slot >= booking.start_time && slot < booking.end_time) ||
            (slot_end > booking.start_time && slot_end <= booking.end_time)
          overlapping_slots << slot
          break # Exit the inner loop early
        end
      end
    end
    daily_datetimes.reject! { |slot| overlapping_slots.include?(slot) }
  end


  def get_client_data(client_id)
    client = Client.find(client_id)
    if client.user == current_user
      current_user_bookings = Booking.passed_confirmed.where(client_id: client_id)
      revenues = 0
      bookings_count = current_user_bookings.count
      current_user_bookings.each do |booking|
        revenues += booking.price
      end
      return { client: client, revenues: revenues, bookings_count: bookings_count }
    else
      return nil # return nil if the client does not belong to the current user
    end
  end

end
