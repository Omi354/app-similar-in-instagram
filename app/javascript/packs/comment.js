import $ from 'jquery'
import axios from 'axios'
import { csrfToken } from 'rails-ujs'

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

$(document).on('turbolinks:load', () => {
  $('.commentBtn').on('click', () => {
    $('.commentArea').toggleClass('hidden')
  })

})