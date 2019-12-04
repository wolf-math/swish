class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
      if user_signed_in?
      @chosen_preferences = current_user.preferences
      # @tweet_lists = TwitterApi.perform(current_user.preferences) || []
      # @youtube_vids = YoutubeApi.all_videos(@chosen_preferences) || []
      @tweet_lists = TWEETS
      else
       @tweet_lists = []
      # @youtube_vids =  []
    end

    @post = Post.new
    @posts = policy_scope(Post).order(created_at: :desc)
    @myposts = current_user.posts.order(created_at: :desc)
    @professionals_posts = Post.where(team_id: current_user.following_by_type('Team').pluck(:id)).or(Post.where(people_id: current_user.following_by_type('Person').pluck(:id))).order(created_at: :desc)
  end

TWEETS = [[{:text=>"#NBA'de bu sezon evinde oynadığı her maçı kazanan sadece üç takım kaldı;\n\n1) Philadelphia 76ers = 10-0\n2) Miami Hea… https://t.co/Bzsdz5Vl62",
   :name=>"NBA Günlükleri",
   :handle=>"NBAGunlukleri",
   :followers=>73435,
   :avatar=>"https://pbs.twimg.com/profile_images/1147493807107256320/tXXW9m_r_normal.jpg",
   :created_at=>"Wed Dec 04 10:49:22 +0000 2019",
   :url=>"https://twitter.com/i/web/status/1202178073602461696",
   :image=>nil},
  {:text=>"RT @sixers: LIVE: 76ers vs. Jazz Postgame Press Conference https://t.co/ZE0UKc5cEx",
   :name=>"Kenneth Harden",
   :handle=>"harden_ken",
   :followers=>1930,
   :avatar=>"https://pbs.twimg.com/profile_images/722875304511934465/OUYuXWU4_normal.jpg",
   :created_at=>"Wed Dec 04 10:42:48 +0000 2019",
   :url=>"https://www.pscp.tv/w/cLXCajE0NzE4fDFqTUtnd0VrcU9xS0yD3bhF-ERaiym-04LKkjcIP0W212kPE66nxet2SAiFAQ==",
   :image=>nil}],
 [{:text=>"It’s too early to quit on the Timberwolves’ two-point guard approach. But will it work? https://t.co/3wkcQEzfjg https://t.co/l9mXlwTJIp",
   :name=>"The Daily Republic",
   :handle=>"dailyrepublic",
   :followers=>4491,
   :avatar=>"https://pbs.twimg.com/profile_images/1151232106904768514/pEnwJgxw_normal.png",
   :created_at=>"Wed Dec 04 10:33:42 +0000 2019",
   :url=>"https://trib.al/qDmI1lx",
   :image=>"https://pbs.twimg.com/media/EK76_99WoAAPbLF.jpg"},
  {:text=>"RT @hoopshype: Minnesota Timberwolves NBA awards: All the winners in team history. https://t.co/RLxOI17aWT https://t.co/YggDppSUuu",
   :name=>"Big3 On Fire Edition",
   :handle=>"Big3OnFirePod",
   :followers=>751,
   :avatar=>"https://pbs.twimg.com/profile_images/882479840745488384/YWrje4QG_normal.jpg",
   :created_at=>"Wed Dec 04 09:40:20 +0000 2019",
   :url=>
    "https://hoopshype.com/2019/08/08/minnesota-timberwolves-nba-awards-all-the-winners-in-team-history/?taid=5de775b6ee0d2300017c91b9&utm_campaign=trueAnthem%3A+Trending+Content&utm_medium=trueAnthem&utm_source=twitter",
   :image=>"https://pbs.twimg.com/media/EK7ltDIXYAEvdq2.jpg"}],
 [{:text=>"RT @Farbod_E: Ivica Zubac and Patrick Beverley signed autographs for every single fan waiting in the tunnel, even the one in a Thunder jers…",
   :name=>"SSTNEWS",
   :handle=>"sstnewsng",
   :followers=>1001,
   :avatar=>"https://pbs.twimg.com/profile_images/1097066631283556353/_l2NcY5w_normal.jpg",
   :created_at=>"Wed Dec 04 07:25:20 +0000 2019",
   :url=>nil,
   :image=>nil},
  {:text=>"RT @charlesmockler: Ivica Zubac on his ability to block guards at the rim, he managed to alter a few shots tonight on smaller guys which wa…",
   :name=>"Los Angeles Clippers Fans",
   :handle=>"LAClippers_Fans",
   :followers=>2317,
   :avatar=>"https://pbs.twimg.com/profile_images/1176615111529660419/G24odZ4S_normal.jpg",
   :created_at=>"Wed Dec 04 06:37:26 +0000 2019",
   :url=>nil,
   :image=>nil}],
 [{:text=>"RT @IanBegley: Knicks say Frank Ntilikina (sore upper back) is listed as questionable for tonight at Milwaukee. Kadeem Allen is with the te…",
   :name=>"Thursday! Knicks - Nuggets",
   :handle=>"KnicksNetwork",
   :followers=>18891,
   :avatar=>"https://pbs.twimg.com/profile_images/1201822579805306880/E1auoGJs_normal.jpg",
   :created_at=>"Mon Dec 02 22:31:26 +0000 2019",
   :url=>nil,
   :image=>nil},
  {:text=>"RT @IanBegley: Knicks say Frank Ntilikina (sore upper back) is listed as questionable for tonight at Milwaukee. Kadeem Allen is with the te…",
   :name=>"Knicks-Yankees -Jets- me7o-Blazers -NYR loyalty",
   :handle=>"forevershinin",
   :followers=>6711,
   :avatar=>"https://pbs.twimg.com/profile_images/1196817404397002755/aICUdO-D_normal.jpg",
   :created_at=>"Mon Dec 02 22:01:53 +0000 2019",
   :url=>nil,
   :image=>nil}],
 [{:text=>"RT @0724q: Samsung 10000V-bucksコードゲッチュしたから\nほしい人RTしてフォローして\nで理由書いてね\nコードチェッカーにも通した https://t.co/lyxnmN55Ev",
   :name=>"chacoco23",
   :handle=>"dLMRonUJttdx21g",
   :followers=>994,
   :avatar=>"https://pbs.twimg.com/profile_images/1192458491383828485/a184bOfM_normal.jpg",
   :created_at=>"Wed Dec 04 10:55:06 +0000 2019",
   :url=>nil,
   :image=>"https://pbs.twimg.com/media/EK7wRVVU8AEDlBP.png"},
  {:text=>"RT @rollbarann: 5 bucks- #TrumpGOP trots out the old “Dems trying to overturn the will of the people” argument\n\nTRUMP LOST BY 3MIL+ VOTES!…",
   :name=>"Kat Resists🐱🌊",
   :handle=>"maine_kat",
   :followers=>3061,
   :avatar=>"https://pbs.twimg.com/profile_images/1201573868139417600/_DNo4sqA_normal.jpg",
   :created_at=>"Wed Dec 04 10:54:59 +0000 2019",
   :url=>nil,
   :image=>nil}],
 [{:text=>"Poeltl also ranks 8th in the league in both screen assists per 36 (tied with DeAndre Jordan) and shots contested pe… https://t.co/fax1Vtsr4c",
   :name=>"Joey Wilkinson 🏁",
   :handle=>"AssassinateHate",
   :followers=>5481,
   :avatar=>"https://pbs.twimg.com/profile_images/1179075349809897472/sBlchsIR_normal.jpg",
   :created_at=>"Wed Dec 04 09:25:23 +0000 2019",
   :url=>"https://twitter.com/i/web/status/1202156937250557952",
   :image=>nil},
  {:text=>"Player of the Week\n\nDecember 02, 2019 - December 08, 2019\n\nPlayer\nLeader Points\nHARWELL, JOSHUA D\n19\nBROUSSEAU, JER… https://t.co/FUZv9CH3X4",
   :name=>"Running Aces Poker",
   :handle=>"RunAcesPoker",
   :followers=>2446,
   :avatar=>"https://pbs.twimg.com/profile_images/1097538489988640769/EyniyDe0_normal.png",
   :created_at=>"Wed Dec 04 08:34:40 +0000 2019",
   :url=>"https://twitter.com/i/web/status/1202144172913889281",
   :image=>nil}]]


end
