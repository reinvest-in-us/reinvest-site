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
                    'rgb(0,0,0)',
                    '#ECDDDE'
                ],
            }],
            labels: [
                'Law Enforcement',
                'Other',
            ]
        },
        options: {
            legend: {
                display: false
            },
        }
    });
}

$(document).ready(function() {
    buildChart('myChart')
});
