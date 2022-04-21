// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "jquery";
import '../../assets/stylesheets/application.scss'
import '@fortawesome/fontawesome-free/js/all'
import 'packs/raty'
window.$ = window.jQuery = require('jquery');


// import 'slick.min.js'
// import './slick'




Rails.start()
Turbolinks.start()
ActiveStorage.start()

