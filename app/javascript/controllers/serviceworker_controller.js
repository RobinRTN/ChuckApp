import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="serviceworker"
export default class extends Controller {
  static targets = ["subscribe"]
  static values = {
    subscription: Object,
    vapidPublicKey: Array
  }

  connect() {
    this.#clearBadge()
    // console.log('connected Subcription Controller')
    this.vapidPublicKey = new Uint8Array(this.vapidPublicKeyValue)
  }

  toggleSubscription(e) {
    const input = e.currentTarget
    input.checked ? this.subscribe(e) : this.unsubscribe(e)
  }

  subscribe(e) {
    e.preventDefault()
    this.#getSubscription()
  }

  unsubscribe(e) {
    e.preventDefault()
    navigator.serviceWorker.ready.then((registration) => {
      registration.pushManager.getSubscription().then((subscription) => {
        this.#deleteSubscriptions()
        if (!subscription) subscription.unsubscribe();
      });
    });
  }

  sendTestNotification(e) {
    e.preventDefault()
    this.#sendTestNotification(e.currentTarget.href)
    // console.log(e.currentTarget.href)
  }

  #sendTestNotification(url) {
    const body = { "message": "pouet" }
    const options = {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify(body)
    }
    fetch(url, options)
  }

  #clearBadge() {
    if (!navigator.clearAppBadge) return

    navigator.clearAppBadge();
  }

  #getSubscription() {
    navigator.serviceWorker.register("/service-worker.js", { scope: "/" })
      .then((registration) => {
        return registration.pushManager.getSubscription()
          .then((subscription) => {
            if (subscription) {
              return subscription;
            }
            return registration.pushManager.subscribe({
              userVisibleOnly: true,
              applicationServerKey: this.vapidPublicKey
            }).catch((err) => {
              window.alert("Couldn't get subscription", err);
            });
          });
      }).then((subscription) => {
        this.#sendSubscription(subscription.toJSON())
      });
  }


  #sendSubscription(subscription) {
    const body = { "subscription": subscription }
    body["subscription"]["device_id"] = this.#deviceId();
    const options = {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify(body)
    }
    fetch('/subscriptions', options)
  }

  #deleteSubscriptions() {
    const options = {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      }
    }
    fetch('/subscriptions', options)
  }

  #deviceId() {
    let deviceId = this.#getCookie('DeviceId');
    if (!deviceId) {
      deviceId = crypto.randomUUID();
      this.#setCookie('DeviceId', deviceId, 365);
    }
    return deviceId;
  }

  #getCookie(cname) {
    let name = cname + "=";
    let decodedCookie = decodeURIComponent(document.cookie);
    let ca = decodedCookie.split(';');
    for (let i = 0; i < ca.length; i++) {
      let c = ca[i];
      while (c.charAt(0) == ' ') {
        c = c.substring(1);
      }
      if (c.indexOf(name) == 0) {
        return c.substring(name.length, c.length);
      }
    }
    return "";
  }

  #setCookie(cname, cvalue, exdays) {
    const d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
    let expires = "expires=" + d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
  }
}
