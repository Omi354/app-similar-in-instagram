// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import $ from 'jquery'
import axios from 'axios'
import { csrfToken } from 'rails-ujs'

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

const initializeModal = () => {
  // モーダルが表示されないように最初に非表示に設定
  $('#modal-overlay').hide()

  // 画像クリックでモーダル表示
  $('.imgWrapper_avatar').on('click', () => {
    $('#modal-overlay').show() // モーダルを表示
  })

  // モーダルの閉じるボタンでモーダルを非表示にする
  $('#close-modal').on('click', () => {
    $('#modal-overlay').hide() // モーダルを閉じる
  })

  // 背景をクリックしてもモーダルを閉じる
  $('#modal-overlay').on('click', (e) => {
    if (e.target === e.currentTarget) { // モーダルの外側をクリックした場合のみ閉じる
      $(e.currentTarget).hide();
    }
  })
}

const closeModal = () => {
  $('#modal-overlay').hide()
}

const showAvatar = () => {
  axios.get('/profile/edit')
  .then(response => {
    const avatarStatus = response.data.hasAvatar
    const avatarUrl = response.data.avatarUrl
    if (avatarStatus === true && avatarUrl) {
      $('#avatar-image').attr('src', avatarUrl).removeClass('hidden')
      $('#default-avatar').addClass('hidden')
    } else {
      $('#default-avatar').removeClass('hidden')
    }
  })
}

const uploadAvatar = () => {
  // inputタグからファイルを取得
  const fileInput = $('#avatar-input')[0]

  // ファイルが選択されていない場合にアラートを表示
  if(!fileInput.files.length) {
    alert('No file selected!')
    return
  }

  const formData = new FormData()
  formData.append('profile[avatar]', fileInput.files[0])

  axios.put('/profile', formData, {
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
  .then(response => {
    console.log('File uploaded successfully:', response.data)
    showAvatar()
    closeModal()

  })
  .catch(error => {
    console.error('Error uploading file:', error);
  })
}


$(document).on('turbolinks:load', () => {
  initializeModal()
  showAvatar()

  $('#uploadAvatarBtn').on('click', (event) => {
    event.preventDefault()
    uploadAvatar()
  })
})




// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
