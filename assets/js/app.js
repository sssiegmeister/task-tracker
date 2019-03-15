import css from "../css/app.scss"

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Bootstrap
import jQuery from 'jquery';
window.jQuery = window.$ = jQuery; // Bootstrap requires a global "$" object.
import "bootstrap";
$(function () {
  $('#submit-time-button').click((ev) => {
    let tid = $(ev.target).data('task-id');
    let start = $('#submit-time-start').val();
    let end = $('#submit-time-end').val();

    let text = JSON.stringify({
      timeblock: {
        task_id: tid,
        start_time: start,
        end_time: end
      }
    });

    $.ajax("/ajax/timeblocks", {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: text,
      success: (resp) => {
        var to_append = "<li id=\"" + resp.data.id + "-entry\">"
          + "Start: " + start + " --------- End: " + end + " "
          + "<button class=\"delete-time-button\" id=\"" + resp.data.id + "-dtb\" data-block-id=\"" + resp.data.id + "\">Delete</button>"
          + "</li>";
        $("#task-logs").append(to_append);
        $("#" + resp.data.id + "-dtb").on('click', function(ev) {
          if (confirm("Are you sure you want to delete this?")) {
            let bid = $(ev.target).data('block-id');

            $.ajax("/ajax/timeblocks/" + bid, {
              method: "delete",
              success: (resp) => {$("#" + bid + "-entry").remove();}
            });
          }
        });
      }
    });
  });
});

// Delete
$(function () {
  $('.delete-time-button').click((ev) => {
    if (confirm("Are you sure you want to delete this?")) {
      let bid = $(ev.target).data('block-id');

      $.ajax("/ajax/timeblocks/" + bid, {
        method: "delete",
        success: (resp) => {$("#" + bid + "-entry").remove();}
      });
    }
  });
});

// Timer Button
$(function() {
  $('#timer-toggle').click((ev) => {
    var d = new Date($.now());
    var now_formatted = d.getFullYear()
                        + "-" + ("0" + (d.getMonth() + 1)).slice(-2)
                        + "-" + ("0" + (d.getDate() + 1)).slice(-2)
                        + " " + ("0" + (d.getHours() + 1)).slice(-2)
                        + ":" + ("0" + (d.getMinutes() + 1)).slice(-2)
                        + ":" + ("0" + (d.getSeconds() + 1)).slice(-2);
    if ($('#timer-toggle').text() == "Start Timer") {
      $('#timer-toggle').text("Stop Timer");
      $('#timer-start-time').text("Start Time: " + now_formatted);
      $('#timer-end-time').text("End Time: ");
    } else {
      $('#timer-toggle').text("Start Timer");
      $('#timer-end-time').text("End Time: " + now_formatted);

      let tid = $(ev.target).data('task-id');
      let start = $('#timer-start-time').text().substring(12);
      let end = now_formatted;

      let text = JSON.stringify({
        timeblock: {
          task_id: tid,
          start_time: start,
          end_time: end
        }
      });

      $.ajax("/ajax/timeblocks", {
        method: "post",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        data: text,
        success: (resp) => {
          var to_append = "<li id=\"" + resp.data.id + "-entry\">"
            + "Start: " + start + " --------- End: " + end + " "
            + "<button class=\"delete-time-button\" id=\"" + resp.data.id + "-dtb\" data-block-id=\"" + resp.data.id + "\">Delete</button>"
            + "</li>";
          $("#task-logs").append(to_append);
          $("#" + resp.data.id + "-dtb").on('click', function(ev) {
            if (confirm("Are you sure you want to delete this?")) {
              let bid = $(ev.target).data('block-id');

              $.ajax("/ajax/timeblocks/" + bid, {
                method: "delete",
                success: (resp) => {$("#" + bid + "-entry").remove();}
              });
            }
          });
        }
      });
    }
  });
});
