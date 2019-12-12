class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if user_signed_in?
      @myposts = current_user.posts.order(created_at: :desc)
      @professionals_posts = Post.where(team_id: current_user.following_by_type('Team').pluck(:id)).or(Post.where(people_id: current_user.following_by_type('Person').pluck(:id))).order(created_at: :desc)
      @post = Post.new
      @posts = policy_scope(Post).order(created_at: :desc)
      @games = Game.all.where(date_time: 1.week.ago..Date.today).order(date_time: :desc)
      @arr = @games.group_by(&:date_time)
      if current_user.called
        @youtube_vids = VIDEOS # Video.where(user: current_user)
        @tweet_lists = TWEETS # Tweet.where(user: current_user)
      else
        @youtube_vids = VIDEOS # YoutubeApi.all_videos(current_user) || []
        @tweet_lists = TWEETS # TwitterApi.perform(current_user) || []
      end
    else
      @myposts = Post.all.order(created_at: :desc)
      @tweet_lists = []
      @youtube_vids = []
    end
  end

  VIDEOS =  [[{ id: "3Tdm-gVioWI", title: "This PROVES Luka Doncic is BETTER than Lebron James at 20 Years Old" }],
             [{ id: "WzOVcr12eps", title: "Los Angeles Lakers vs Orlando Magic Full Game Highlights | December 11, 2019-20 NBA Season" }],
             [{ id: "Ocjn3lIhfhQ", title: "Houston Rockets vs Cleveland Cavaliers Full Game Highlights | December 11, 2019-20 NBA Season" }],
             [{ id: "7JouapsFycA", title: "James Harden Drops 55 Pts, 10 Threes vs Cavs | Dec 11, 2019 | FreeDawkins" }],
             [{ id: "t6FaWgH4iUQ", title: "Luka Doncic Breaks MJ Reord 2019.12.08 Mavs vs Kings - 27 Pts, 8 Asts, 7 Rebs | FreeDawkins" }],
             [{ id: "ADLyNFJ4FQk", title: "The Best NBA Game Marc Stein Ever Covered | Bill Simmons’s Book of Basketball 2.0 | The Ringer" }],
             [{ id: "cipiNODn5FU", title: "LeBron James Triple-Double 2019.12.11 Lakers vs Magic - 25 Pts, 11 Rebs, 10 Asts! | FreeDawkins" }],
             [{ id: "_IUe_VNdERA", title: "LeBron James postgame interview | Lakers vs Magic" }],
             ]

  TWEETS = [[{ text: "Wow!! Ball game. What A Game! Best game of the year thus far! #49ersvsSaints",
               name: "LeBron James",
               handle: "KingJames",
               followers: 44100000,
               avatar: "https://pbs.twimg.com/profile_images/1010862750401253377/Rof4XuYC_400x400.jpg",
               created_at: "Thu Dec 12 10:49:22 +0000 2019",
               url: nil,
               image: nil },

             { text: "halftime report on tnt is the best show 😂😂😂😂 @SHAQ @NBAonTNT",
               name: "Luka Doncic",
               handle: "luka7doncic",
               followers: 538000,
               avatar: "https://pbs.twimg.com/profile_images/1034982555538284544/BEeQmYf-_400x400.jpg",
               created_at: "Thu Dec 12 10:42:48 +0000 2019",
               url: nil,
               image: nil }],

            [{ text: "Maaan what????  Can’t end it like that !!! No way!",
               name: "James Harden",
               handle: "JHarden13",
               followers: 4491,
               avatar: "https://pbs.twimg.com/profile_images/799472766869237760/8UPlPkqJ_400x400.jpg",
               created_at: "Thu Dec 12 10:33:42 +0000 2019",
               url: nil,
               image: nil },

             { text: "Luka Doncic started his rookie season with a 79 #2KRatings


                     Started his second season at 87.

                     He’s now a 96!",
               name: "Ballislife.com",
               handle: "Ballislife",
               followers: 567000,
               avatar: "https://pbs.twimg.com/profile_images/1053027014544842752/QHplPv0Y_400x400.jpg",
               created_at: "Thu Dec 12 09:40:20 +0000 2019",
               url: nil,
               image: "https://pbs.twimg.com/media/ELJPPYWWoAEogIo_400x400.jpg" }],

            [{ text: "Tuesday: 25 points
                      Wednesday: 26 points
                      Friday: 39 points
                      Sunday:
                      5️⃣
                      0️⃣


                      @AntDavis23
                       just keeps getting better.",
               name: "Los Angeles Lakers",
               handle: "Lakers",
               followers: 1001,
               avatar: "https://pbs.twimg.com/profile_images/1195418362588758016/0lkT58cM_400x400.jpg",
               created_at: "Wed Dec 04 07:25:20 +0000 2019",
               url: nil,
               image: nil },

             { text: "Luka Doncic is the 2nd player under the age of 21 to score at least 600 points in his first 20 games of a season.

                      He joins LeBron James in 2005-06 as the only player to accomplish this feat. Both Luka and LeBron scored exactly 614 points.",
               name: "ESPN Stats & Info",
               handle: "ESPNStatsInfo",
               followers: 1700000,
               avatar: "https://pbs.twimg.com/profile_images/747495844157472769/Np_LXZ_x_400x400.jpg",
               created_at: "Thu Dec 12 06:37:26 +0000 2019",
               url: nil,
               image: "https://pbs.twimg.com/media/EK6m5xvWkAAB2P-?format=jpg&name=small" }],

            [{ text: "Mark Cuban became the majority owner of the Dallas Mavericks in 2000 after buying it for $285 million.

                      The team is now worth $2.25 billion today
                      🤯
                      💰",
               name: "Hot Freestyle",
               handle: "HotFreestyle",
               followers: 456000,
               avatar: "https://pbs.twimg.com/profile_images/854890558283595776/U5AkPb_g_400x400.jpg",
               created_at: "Thu Dec 12 22:31:26 +0000 2019",
               url: nil,
               image: "https://pbs.twimg.com/media/EK4mFR8WsAAxqKD?format=jpg&name=900x900" },

               { text: "In 2005, Kobe Bryant put up 62 points in 3 quarters against the Dallas Mavericks.

                        Phil Jackson had the assistant coach, Brian Shaw, ask Kobe if he wanted to play the 4th & get 70.

                        Kobe replied “nah I’ll get it another time” and decided to rest.

                        He dropped 81 later that season",
                 name: "The Truth Hurts",
                 handle: "NBATruthHurts",
                 followers: 4316,
                 avatar: "https://pbs.twimg.com/profile_images/1188632896652877824/CDpTRsPk_400x400.jpg",
                 created_at: "Thu Dec 12 22:01:53 +0000 2019",
                 url: nil,
                 image: nil }],

            [{ text: "👑
  📍
                      Brandon ‘Scoop B’ Robinson
                      @ScoopB
                      Los Angeles Lakers are not winning the NBA Finals says @MichaelRapaport
                      : http://bit.ly/2P9w1Xd

                      'The Clippers are winning the Championship.'

                      'The Clippers are a major problem and the Lakers have been great. They've got two and a half centers.' ",
               name: "Kat Resists🐱🌊",
               handle: "maine_kat",
               followers: 3061,
               avatar: "https://pbs.twimg.com/profile_images/1201573868139417600/_DNo4sqA_normal.jpg",
               created_at: "Wed Dec 04 10:54:59 +0000 2019",
               url: nil,
               image: nil }]]
end
