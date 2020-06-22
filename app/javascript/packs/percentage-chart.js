import $ from 'jquery';
import Chart from 'chart.js';

export function buildChart(canvasId) {
    var ctx = document.getElementById(canvasId);
    const percent = parseInt(ctx.attributes['data-general_fund_spent_on_police_percentage'].value);
    var myChart = new Chart(ctx, {
        type: 'pie',
        data: {
            datasets: [{
                data: [percent, 100 - percent],
                backgroundColor: [
                    '#2b2d42',
                    '#ECDDDE'
                ],
            }],
            labels: [
                'Law Enforcement',
                'Other',
            ]
        },
        options: {
            hover: {
                mode: null,
            },
            legend: {
                display: false,
            },
            tooltips: {
                enabled: false,
            },
        }
    });
}

$(document).ready(function() {
    buildChart('myChart')
});
