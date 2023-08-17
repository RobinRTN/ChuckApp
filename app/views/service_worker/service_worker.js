const onInstall = (event) => {
  console.log('[Serviceworker]', "Installing!", event);
}

const onActivate = (event) => {
  console.log('[Serviceworker]', "Activating!", event);
}

// const onFetch = (event) => {}

const onPush = (event) => {
  console.log("==========")
  console.log('[Serviceworker]', "Push Received!", event);

  if (!event.data) {
    console.log("[Serviceworker] No data found in push event!");
    return;
  }

  let payload;
  try {
    payload = event.data.json();
    console.log("===========")
    console.log("Parsed payload:", payload);
  } catch (error) {
    console.error("[Serviceworker] Error parsing payload:", error);
    return;
  }

  const title = payload.title || "Default title";
  const options = {
    body: payload.body,
    data: payload.data
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

function onNotificationClick(event) {
  event.notification.close()
  event.waitUntil(clients.openWindow(event.notification.data.url))
}

self.addEventListener('install', onInstall);
self.addEventListener('activate', onActivate);
// self.addEventListener('fetch', onFetch);
self.addEventListener("push", onPush);
self.addEventListener('pushsubscriptionchange', onPushSubscriptionChange);
self.addEventListener('notificationclick', onNotificationClick);


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
