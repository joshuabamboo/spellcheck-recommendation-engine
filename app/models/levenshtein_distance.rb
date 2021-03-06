class LevenshteinDistance < ActiveRecord::Base
  def initialize
    @users = User.all_users
  end

  def levenshtein_distance(input_name, db_name)
    input_name_size = input_name.length
    db_name_length = db_name.length
    return input_name_size if db_name_length == 0
    return db_name_length if input_name_size == 0
    d = Array.new(input_name_size+1) {Array.new(db_name_length+1)}

    (0..input_name_size).each {|i| d[i][0] = i}
    (0..db_name_length).each {|j| d[0][j] = j}
    (1..db_name_length).each do |j|
      (1..input_name_size).each do |i|
        d[i][j] = if input_name[i-1] == db_name[j-1]   # adjust index into string
                    d[i-1][j-1]                        # no operation required
                  else
                    [ d[i-1][j]+1,                     # deletion
                      d[i][j-1]+1,                     # insertion
                      d[i-1][j-1]+1,                   # substitution
                    ].min
                  end
      end
    end
    d[input_name_size][db_name_length]
  end

  # def similar_enough?(distance)
  #   distance < 9
  # end

  def get_closest_match(input_name)
    matches={}
    @users.each {|user| matches[user.name]=levenshtein_distance(input_name, user.name)}
    min_distance = matches.values.min
    # if similar_enough?(min_distance)
      @closest_match = matches.select { |k, v| v == min_distance }.keys
    # else
    #   @closest_match = nil
    # end
  end

  def get_closest_match_id
    id=[]
    if !@closest_match.nil?
      @closest_match.each do |user_name|
        user_instance = @users.find_by name: user_name
        id << user_instance.id
      end
    end
    id
  end

end