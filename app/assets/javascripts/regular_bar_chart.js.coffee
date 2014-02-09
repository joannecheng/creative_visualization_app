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
    title:
      text: 'Issue Creation by Date'
    plotOptions:
      line:
        marker:
          enabled: false
    series: [
      name: 'Number issues created'
      data: data.data
    ]

numberOfDaysGraph = {}
averageNumberOfDays = {}
newIssuesPerDay = {}
closedIssuesPerDay = {}

createCommentTimeline = (data) ->
  w = 1800
  h = 500
  padding = 10

  arcData = (d) ->
    closed_at = Date.parse(d.closed_at)

    unless d.closed_at?
      closed_at = new Date
      # return []

    created_at = Date.parse d.created_at
    [created_at, created_at + 10, closed_at - 10, closed_at]

  svg = d3.select('#comment_timeline')
    .append('svg')
    .attr('class', 'comment-timeline-container')
    .attr('width', w)
    .attr('height', h)

  container = svg.append('g')
    .classed('container', true)

  minDate = d3.min(data, (d) -> Date.parse(d.created_at))
  maxDate = new Date

  xScale = d3.time.scale().domain([minDate, maxDate]).range([padding, w - padding])
  yScale = d3.scale.linear().domain([0, (maxDate - minDate)]).range([h, 100])

  xAxis = d3.svg.axis().scale(xScale).orient('bottom')

  container.append('g')
    .classed('axis', true)
    .call(xAxis)
    .attr('transform', "translate(0, 400)")

  lineGenerator = (elem) ->
    d3.svg.line()
      .x((d) -> xScale(d))
      .y((d, i) ->
        if i == 0 || i == elem.length - 1
          yScale(400)
        else
          yScale(elem[3] - elem[0])
      ).interpolate('basis')

  arcs = svg.selectAll('.arc')
    .data(data).enter()
    .append('path')
    .classed('arc', true)
    #.classed('pull-request', (d) -> d.is_pull_request)
    .attr('d', (d) ->
      lineGenerator(arcData(d))(arcData(d))
    )
    .attr('transform', 'translate(0, -100)')

$ ->
  $.get('/issues/by_count.json', createOpenClosedGraph)
  $.get('/issues/new_issues_by_day', createIssuesByDayGraph)
  $.get('/issues/timeline.json', createCommentTimeline)
