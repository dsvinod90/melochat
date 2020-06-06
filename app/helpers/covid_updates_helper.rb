module CovidUpdatesHelper
    def data_for_line_graph(all_status)
        weekly_data = all_status.select.with_index { |_, index| index % 7 == 0 }
        confirmed = weekly_data
            .group_by { |hash| converted_date(hash['Date']) }
            .map { |k, v| { k=>v.first['Confirmed'] } }
            .reduce(:merge)
        deaths = weekly_data
            .group_by{|hash| converted_date(hash['Date']) }
            .map{|k, v| { k=>v.first['Deaths'] } }
            .reduce(:merge)
        recovered = weekly_data
            .group_by{|hash| converted_date(hash['Date']) }
            .map{|k, v| { k=>v.first['Recovered'] } }
            .reduce(:merge)
        [{name: 'Confirmed', data: confirmed}, {name: 'Deaths', data: deaths}, {name: 'Recovered', data: recovered}]
    end

    def converted_date(date)
        Date.parse(date).strftime('%Y-%m-%d')
    end
end
