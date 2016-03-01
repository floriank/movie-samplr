FactoryGirl.define do
  factory :dataset do
    title 'Deadpool'
    plot %{A former Special Forces operative turned mercenary is subjected to a rogue experiment that leaves him with accelerated healing powers, adopting the alter ego Deadpool.}
    plot_summary %{This is the origin story of former Special Forces operative turned mercenary Wade Wilson, who after being subjected to a rogue experiment that leaves him with accelerated healing powers, adopts the alter ego Deadpool. Armed with his new abilities and a dark, twisted sense of humor, Deadpool hunts down the man who nearly destroyed his life.}
    year 2016
    tagline 'Feel the love.'
    imdb_id '1431045'
    poster_url 'hellokitty.jpg'
    cast ['Ryan Reynolds', 'Morena Baccarin', 'T.J. Miller']
    director ['Tim Miller']
  end
end
