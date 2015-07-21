namespace :competition do
  desc 'Reset rating, delete inactive users, remove old tasks'
  task :start => :environment do
    # RATING_TRESHOLD = (ENV['RATING_TRESHOLD'] || 1).to_i
    # USERS_TRESHOLD = (ENV['USERS_TRESHOLD'] || 2).to_i

    # active_users = User.count(:conditions => ['rating >= ?', RATING_TRESHOLD])
    # if active_users >= USERS_TRESHOLD
    #   puts "Keeping #{active_users} of #{User.count} users"
    #   User.delete_all(['rating < ?', RATING_TRESHOLD])
    # else
    #   puts "User treshold not reached (#{active_users}/#{USERS_TRESHOLD})"
    #   puts 'Append "USER_TRESHOLD=u RATING_TRESHOLD=r" to override'
    #   puts "Keeping all #{User.count} users"
    # end

    Task.destroy_all
    User.update_all(rating: 0, level: 1, winner: false, win_at: nil)
  end
end
