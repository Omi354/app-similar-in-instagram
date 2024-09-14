// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import $ from 'jquery'

$(document).ready(function() {
  // モーダルが表示されないように最初に非表示に設定
  $('#modal-overlay').hide();
  
  // 画像クリックでモーダル表示
  $('#avatar-image').on('click', function() {
    $('#modal-overlay').show(); // モーダルを表示
  });

  // モーダルの閉じるボタンでモーダルを非表示にする
  $('#close-modal').on('click', function() {
    $('#modal-overlay').hide(); // モーダルを閉じる
  });

  // 背景をクリックしてもモーダルを閉じる
  $('#modal-overlay').on('click', function(e) {
    if (e.target === this) { // モーダルの外側をクリックした場合のみ閉じる
      $(this).hide();
    }
  });
});


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
