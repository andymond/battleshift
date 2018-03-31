// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require_tree .

var register = document.querySelector(".register-button");
var registerForm = document.querySelector(".register-hidden");
register.addEventListener("click", showRegister);
var login = document.querySelector(".login-button");
var loginForm = document.querySelector(".login-hidden")
login.addEventListener("click", showLogin);

function showRegister () {
  register.classList.toggle("hidden")
  registerForm.classList.toggle("register")
  login.className = "login-button"
}

function showLogin () {
  login.classList.toggle("hidden")
  loginForm.classList.toggle("login-form")
  register.className = "register-button"
}
