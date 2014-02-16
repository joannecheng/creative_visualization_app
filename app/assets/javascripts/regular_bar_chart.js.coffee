createOpenClosedGraph = (data) ->
  $('#bar_graph_container').highcharts
    chart:
      type: 'column'
    title:
      text: 'Open vs Closed Issues on Rails'
    series: data

createIssuesByDayGraph = (data) ->
  $('#issues_by_day_container').highcharts
    chart:
      type: 'line'
      height: 600
      width: 1600
      marginRight: 50
    title:
      text: 'Issue Creation by Date'
    yAxis:
      min: 0
    xAxis:
      labels:
        step: 28
        rotation: 45
      categories:
        data.x_axis
    plotOptions:
      line:
        marker:
          enabled: false
    series: [
      name: 'Number issues created'
      data: data.data
    ]

$ ->
  if $('#bar_graph_container').length > 0
    $.get('/issues/by_count', createOpenClosedGraph)

  if $('#issues_by_day_container').length > 0
    $.get('/issues/new_issues_by_day', createIssuesByDayGraph)
