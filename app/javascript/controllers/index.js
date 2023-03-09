// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import BottomController from "./bottom_controller"
application.register("bottom", BottomController)

import CopyToClipboardController from "./copy_to_clipboard_controller"
application.register("copy-to-clipboard", CopyToClipboardController)

import DropdownController from "./dropdown_controller"
application.register("dropdown", DropdownController)

import FormuleController from "./formule_controller"
application.register("formule", FormuleController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import ReservationController from "./reservation_controller"
application.register("reservation", ReservationController)

import SimpleCalendarController from "./simple_calendar_controller"
application.register("simple-calendar", SimpleCalendarController)

import SweetAlertController from "./sweet_alert_controller"
application.register("sweet-alert", SweetAlertController)
