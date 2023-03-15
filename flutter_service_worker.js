'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "7b662c10257dc44d6eb74933aa765c47",
"assets/AssetManifest.json": "5d41049d475500543c487d0969ccffd6",
"assets/assets/avaters/Avatar%25201.jpg": "60f969aae689291e30cffc6deafd1ec2",
"assets/assets/avaters/Avatar%25202.jpg": "9eecb4a8f2da90198bf8c4f8c3e8c527",
"assets/assets/avaters/Avatar%25203.jpg": "4431bc261ac4f57a09dc1e041b32b4d1",
"assets/assets/avaters/Avatar%25204.jpg": "95617f142e8dcfa6547ea80557eee016",
"assets/assets/avaters/Avatar%25205.jpg": "405a74c93f4806312fcd25e7722d9f90",
"assets/assets/avaters/Avatar%25206.jpg": "57b1f154ef47c7a76a78544e9e6af44f",
"assets/assets/avaters/Avatar%2520Default.jpg": "fe9d7eaf1b437a1e6c84f1e6fdb77dcf",
"assets/assets/Backgrounds/Spline.png": "ff232f0cf3ebd732ca4383c381450714",
"assets/assets/fonts/Inter-Regular.ttf": "eba360005eef21ac6807e45dc8422042",
"assets/assets/fonts/Inter-SemiBold.ttf": "3e87064b7567bef4ecd2ba977ce028bc",
"assets/assets/fonts/Poppins-Bold.ttf": "08c20a487911694291bd8c5de41315ad",
"assets/assets/icons/apple_box.svg": "3f634f4f80414d88ada3193069b4f961",
"assets/assets/icons/Arrow%2520Right.svg": "82b7f5520958b35402d7576d20fb5186",
"assets/assets/icons/call.svg": "43ec9835e9f4d5ed09b96e6102270f32",
"assets/assets/icons/code.svg": "516c08c5e685a49b79fa87d0cc2f7641",
"assets/assets/icons/email-icon.svg": "8f9fc9f9553cb7a07f158399c338ec69",
"assets/assets/icons/email.svg": "1ae885eb1fdb247400ac0400112ddefb",
"assets/assets/icons/email_box.svg": "a09e0cb77621a100cfe8c98593b9f422",
"assets/assets/icons/eye-off.svg": "59bf2b8755d2109322c3de630dd7a5f6",
"assets/assets/icons/eye-on.svg": "e51ecc5222d85edd05adc881871f33f5",
"assets/assets/icons/facebook.svg": "a439e3e08fd1c1721c7aee597e77dd13",
"assets/assets/icons/google.svg": "1a0f9aa57f2b71ee7604f146ec9352fb",
"assets/assets/icons/google_box.svg": "9f643ad1c6e2731879c4eb501357d784",
"assets/assets/icons/home.svg": "a016e892bcf10a348014896e71242a3b",
"assets/assets/icons/instagram.svg": "b3b7a0210038e9a9f2fcb54f17d0f1c1",
"assets/assets/icons/ios.svg": "45b815957b353fc2c4b56e2e3779d6f3",
"assets/assets/icons/library.svg": "6d34079ad8840f594ac5b6571cff92a9",
"assets/assets/icons/multiple-users.svg": "60a31d42ade439d4af199816a962d5ca",
"assets/assets/icons/password-icon.svg": "c12ca346399c34e703c0fbc40b8f8fbc",
"assets/assets/icons/password.svg": "64a726ac604a3e6228987eeb9c10bc71",
"assets/assets/icons/profile_img.png": "bdd25e977a6858b7413f720188f721c3",
"assets/assets/icons/search.svg": "7e06de60abc67865a5c01663ec763933",
"assets/assets/icons/twitter.svg": "72e85266654b092eded13553abc64574",
"assets/assets/icons/User.svg": "5eb1b43b454f1e763da0928d4841c138",
"assets/assets/images/bizCardLogo.png": "76ff7654f61ab8fe222d5e516385049b",
"assets/assets/images/coverImage.jpg": "d548645b2cd3dbe1aa24019eb5c4dc1b",
"assets/assets/images/facebook.png": "b53eaee4a6eae96fb3036d722f97c19d",
"assets/assets/images/git.png": "5c06dbd786e632cc839d1b2816946d2f",
"assets/assets/images/instagram.png": "72a4b561233cbeed9b490e76dd57af83",
"assets/assets/images/instagram1.png": "5c570427ee23f69853d28aec805eee79",
"assets/assets/images/linkedIn.png": "40b5c0522304acc161f7db845dd66cd3",
"assets/assets/images/twitter.png": "c228a51f52d262f60b78c320bb8fb782",
"assets/assets/images/whatsapp.png": "6d4d8f6a54c49c64c81d3408745c60b4",
"assets/assets/RiveAssets/button.riv": "c8ffe2900d31d8236247928cd7c2b5f3",
"assets/assets/RiveAssets/check.riv": "14f9269423eabd7e2e10cafdc6ad4d41",
"assets/assets/RiveAssets/confetti.riv": "ad0d13cbea799085305316f0e8118274",
"assets/assets/RiveAssets/house.riv": "3ac77437a4c56b5143d6ceca83dd61d9",
"assets/assets/RiveAssets/icons.riv": "3d29f9acebef13f01f371b59e84e664b",
"assets/assets/RiveAssets/menu_button.riv": "f8fdfd9fd8dc7873dfac6f005f3233c1",
"assets/assets/RiveAssets/shapes.riv": "8839d67714d5e9c52b3e0dbb2b1e89c1",
"assets/assets/shapes/Circle.svg": "27c4568daf6d16902fc3b45761882799",
"assets/assets/shapes/Hexagon.svg": "e5e146b3cf9e2ac19e32c94073eedbc3",
"assets/assets/shapes/Triangle.svg": "69dc6aa6ed087440a346d8b0ecc8dc60",
"assets/FontManifest.json": "2713a9f6c7ad1f89ffa129d8275a14fd",
"assets/fonts/MaterialIcons-Regular.otf": "5d3706a0c29882cbe5170566e48d9cdc",
"assets/NOTICES": "451663c3efe88630845c6464af1afb07",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "93cafdfb09fb987b24d77f3667baca43",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "0694916c8bb69ac850e24da716a6eb48",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "01bb14ae3f14c73ee03eed84f480ded9",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "99d45f98c5ac98517eb5cba57d3fabc0",
"assets/shaders/ink_sparkle.frag": "57f2f020e63be0dd85efafc7b7b25d80",
"canvaskit/canvaskit.js": "3e7c7e90ff8e206f4023c12e31b0d058",
"canvaskit/canvaskit.wasm": "663e2d8dc95b3eb6e813db7288f90115",
"canvaskit/chromium/canvaskit.js": "f39c7fbb70c7d277f537a7c366d75533",
"canvaskit/chromium/canvaskit.wasm": "b5bbefa86d22f7a1e94cda2a490b58bf",
"canvaskit/skwasm.js": "569eed0f1ca775eb9a112f5821ad278b",
"canvaskit/skwasm.wasm": "e5af8ff2312130582de5a1d858b06c25",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "862fac3a64bed5d565b73fc54f485610",
"/": "862fac3a64bed5d565b73fc54f485610",
"main.dart.js": "672adc2f375115a857e45c64ae49674b",
"manifest.json": "b1d89c882a9f1ced1be9476717b005a0",
"version.json": "7932913664c7f9a51688a5be208a2e7b"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
