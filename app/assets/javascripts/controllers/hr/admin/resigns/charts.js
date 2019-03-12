//= require chart.js/dist/Chart.js

$(document).ready(function () {
    var ctx1 = $('#chart1');
    // var ctx2 = $('#chart2');
    var main_chart = data.main_chart;
    new Chart(ctx1, {
        type: 'bar',
        data: {
            datasets: main_chart.datasets,
            labels: main_chart.labels,
        },
        options: {
            title: {
                display: true,
                text: 'MDPI Resign Reasons Analysis',
                fontSize: 14,
            },
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true,
                        stepSize: 1,
                    }
                }]
            },
            events: ['click'],
            onClick: function (e) {
                console.log(e.target);
            }

        }
    });
    // var module_chart = data.module_chart;
    // new Chart(ctx2 ,{
    //     type: 'bar',
    //     data: {
    //         datasets: module_chart.datasets,
    //         labels: module_chart.labels,
    //     },
    //     options: {
    //         title: {
    //             display: true,
    //             text: 'MDPI Resign Reasons Analysis',
    //             fontSize: 14,
    //         },
    //         scales: {
    //             yAxes: [{
    //                 ticks: {
    //                     beginAtZero: true,
    //                     stepSize: 1,
    //                 }
    //             }]
    //         }
    //     }
    // });
});
