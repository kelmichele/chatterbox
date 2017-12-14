App.customer_chat = App.cable.subscriptions.create("CustomerChatChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    var customer_chat = $('#customer_chats-list').find("[data-customer_chat-id='" + data['customer_chat_id'] + "']");

    if (data['window'] !== undefined) {
      var customer_chat_visible = customer_chat.is(':visible');

      if (customer_chat_visible) {
        var notes_visible = (customer_chat).find('.panel-body').is(':visible');

        if (!notes_visible) {
          customer_chat.removeClass('panel-heading').addClass('panel-success');
        }
        customer_chat.find('.notes-list').find('ul').append(data['note']);
      }
      else {
        $('#customer_chats-list').append(data['window']);
        customer_chat = $('#customer_chats-list').find("[data-customer_chat-id='" + data['customer_chat_id'] + "']");
        customer_chat.find('.panel-body').toggle();
      }
    }
    else {
      customer_chat.find('ul').append(data['note']);
    }

    var notes_list = customer_chat.find('.notes-list');
    var height = notes_list[0].scrollHeight;
    notes_list.scrollTop(height);
  },
  speak: function(note) {
    return this.perform('speak', {
      note: note
    });
  }
});
$(document).on('submit', '.new_note', function(e) {
  e.preventDefault();
  var values = $(this).serializeArray();
  App.customer_chat.speak(values);
  $(this).trigger('reset');
});
