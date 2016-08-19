// FramerJS vendor
require("./framer/framer.js")
require("./framer/framer.generated.js")
require("./framer/style.css")

// Custom scripts
require('./app.coffee');

if (module.hot) {
  module.hot.accept();
}
