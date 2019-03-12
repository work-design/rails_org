//= require rails_com/footer
//= require default_form/footer
//= require flatpickr

$('#navbar_dropdown').dropdown();
$('#attendance_dropdown').dropdown({
  on: 'hover'
});

$('.ui.radio.checkbox').checkbox();

$("input[type=date]").flatpickr({});
$("input[type=datetime], input[type=datetime-local]").flatpickr({
    enableTime: true,
    dateFormat: "Y-m-d H:i",
    time_24hr: true,
});
$("input[type=time]").flatpickr({
    enableTime: true,
    noCalendar: true,
    dateFormat: "H:i",
    time_24hr: true
});
