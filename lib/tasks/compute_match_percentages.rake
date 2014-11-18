desc "Compute the match percentages for all of the user pairs in a section"
task :compute_match_percentages => :environment do
  ("A".."J").each do |section|
    puts "Section #{section}"
    User.in_section(section).each do |u1|
      m = MatchPercentageService.new(u1)

      User.in_section(section).each do |u2|
        m.compute_score(u2)
      end
    end
  end
end
