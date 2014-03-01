w = 1400
h = 2400
maxDiameter = 40
columnCount = w/maxDiameter - 1

svg = d3.select('.content')
  .append('svg')
  .attr('width', w)
  .attr('height', h)

d3.json '/issues/age_and_number_comments.json', (issueDataArray) ->
  ageInDaysScale = d3.scale.linear()
    .domain([0, 60])
    .range([1, 0])

  numberCommentsScale = d3.scale.pow()
    .exponent(0.5)
    .domain([0, 35])
    .range([1, maxDiameter/2])

  circles = svg.selectAll('circle.issue')
    .data(issueDataArray)
    .enter()
    .append('circle')
    .classed('issue', true)
    .attr('cx', (d, i) -> i%columnCount * maxDiameter)
    .attr('cy', (d, i) -> parseInt(i/columnCount) * maxDiameter)
    .attr('r', (d) -> numberCommentsScale(d.number_comments))
    .attr('transform', 'translate(40, 40)')
    .attr('fill', (d) ->
      if d.is_pull_request
        'steelblue'
      else
        '#444'
    )
    .attr('stroke', 'black')
    .attr('stroke-width', 2)
    .attr('stroke-dasharray', (d) ->
      if d.state == 'open'
        '3,2'
    )
    .attr('fill-opacity', (d) ->
      ageInDaysScale(d.age_in_days)
    )















































#  ageInDaysScale = d3.scale.linear().domain([1, 35]).range([1, 0])
#
#  # we scale to reflect the relative square root of the radius here -
#  # we want the *area* of the circle, which is the square of the radius
#  # to represent the number of comment
#  numberCommentsScale = d3.scale.pow().exponent(0.5).domain([0, 35]).range([3, maxDiameter/2])
#
#  circles = svg.selectAll('circle.issue')
#    .data(issueDataArray)
#    .enter()
#    .append('circle')
#    .attr('r', (d) -> numberCommentsScale(d.number_comments))
#    .attr('cx', (d, i) -> i%columnCount * maxDiameter)
#    .attr('cy', (d, i) -> parseInt(i/columnCount) * maxDiameter)
#    .classed('issue', true)
#    .attr('stroke-width', 2)
#    .attr('stroke', 'black')
#    .attr('stroke-dasharray', (d) ->
#      if d.state == 'open'
#        '3,2'
#    )
#    .attr('fill-opacity', (d) ->
#      ageInDaysScale(d.age_in_days)
#    )
#    .attr('fill', (d) ->
#      if d.is_pull_request
#        'steelblue'
#      else
#        '#555'
#    )
#    .attr('transform', 'translate(40, 40)')
