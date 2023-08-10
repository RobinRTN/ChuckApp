const onInstall = (event) => {
  console.log('[Serviceworker]', "Installing!", event);
}

const onActivate = (event) => {
  console.log('[Serviceworker]', "Activating!", event);
}

const onFetch = (event) => {}

const onPush = (event) => {
  console.log('[Serviceworker]', "Push Received!", event);
  // var payload = event.data.json();

  const img = "https://cdn-icons-png.flaticon.com/512/3119/3119338.png";
  const text = "New notification";
  const title = "You have received a new notification";
  const options = {
    body: text,
    icon: img,
    vibrate: [200, 100, 200],
    image: img,
    badge: 3,
  };
  event.waitUntil(self.registration.showNotification(title, options));
  event.waitUntil(
    navigator.setAppBadge().catch((error) => {
      console.log(error);
    })
  );
}

const onPushSubscriptionChange = (event) => {
  console.log('[Serviceworker]', "Push Subscription Changing!", event);
  event.waitUntil(
    fetch(`/subscriptions`, {
      method: 'PATCH',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        old_subscription: event.oldSubscription ? event.oldSubscription.toJSON() : null,
        new_subscription: event.newSubscription ? event.newSubscription.toJSON() : null,
        device_id: getCookie("device_id")
      })
    })
  );
}

self.addEventListener('install', onInstall);
self.addEventListener('activate', onActivate);
self.addEventListener('fetch', onFetch);
self.addEventListener("push", onPush);
self.addEventListener('pushsubscriptionchange', onPushSubscriptionChange);

const getCookie = (cname) => {
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
