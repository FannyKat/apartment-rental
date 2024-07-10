// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"

import { Turbo } from "@hotwired/turbo-rails"
Turbo.start()

import "@fortawesome/fontawesome-free";

import "controllers"

import "./controllers/image-modal-controller.js"
import "./controllers/navbar-burger-controller.js"
import "./controllers/carousel-controller.js"