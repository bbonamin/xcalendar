# XCalendar

Cross Country Soaring calendar builder, used to assign pilots to available club gliders (2 in this case), in a custom date range.

## Usage

1. Create the calendar & export the results to a CSV file.

```ruby
calendar = XCalendar::Calendar.new(start_date: '2019-10-11', end_date: '2020-04-06')
calendar.export_to_csv
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

XCalendar::Calendar.new(start_date: '2019-01-05', end_date: '2019-04-06')
