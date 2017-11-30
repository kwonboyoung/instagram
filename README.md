## 어플리케이션 배포

using aws lightsail

https://github.com/classjohn/server_setup



https://github.com/classjohn/setup_guides

<Passenger로 Rails 실행하기 본인의 ip로 접속해서 확인하기> 전까지만



#### AWS

- light shail : ubuntyu 16.04(인스턴스는 하나만 돌아가도록)
- https://github.com/classjohn/server_setup
- gorails deploy rubyonrails : https://gorails.com/deploy/ubuntu/16.04



1. [Light shail](https://lightsail.aws.amazon.com)

1) Light shail OS 전용 Ubuntu 16.04 인스턴스 생성

2) git clone https://github.com/classjohn/server_setup.git

3) shell 스트립트 짜보기

- 권한 보기

  ```
  $ ls -al
  ```


- vi hello.sh

  ```
  #!bin/bash
  echo "Hello"
  ```

- 권한 부여

  ```
  $ sudo chmod u+x hello.sh
  # u : user
  # x : 실행 권한 
  # 즉 유저에게 실행권한을 주겠다
  ```

- 파일 실행

  ```
  $ . hello.sh
  ```

4) git에서 받은 clone에 권한 부여

```
$ cd server_setup/
$ sudo chmod u+x ~/server_setup/*.sh
```

5) server setup

```
$ ~/server_setup/setup.sh
```

6) 확인

```
$ rvenv --version
```

7)  ruby 설치

```
$ rbenv install 2.3.5
$ rbenv global 2.3.5
$ gem install bundler
$ rbenv rehash
```

8) rails 설치

```
$ gem install rails -v 4.2.9
```

---

####  [Nginx](https://nginx.org/en/) : 웹서버

- https://ko.wikipedia.org/wiki/Nginx
- [생활코딩 nginx](https://opentutorials.org/module/384/3463)
- https 인증서 : https://letsencrypt.org/
- gorails : https://gorails.com/deploy/ubuntu/16.04#nginx-passenger



##### 설명 : https://github.com/likelion-campus/guides

1. 설치

1) nginx.sh 실행

```
$ ~/server_setup/nginx.sh
```

2) nginx 서버 실행

```
$ sudo service nginx start
```

3) 확인

- light shail 인스턴스의 공개 IP로 들어간다.
- "welcome to nginx!"가 뜨면 성공



2. Nginx 서버 설정

1) 관리 파일 접속

```
$ sudo vim /etc/nginx/nginx.conf
```

2) Pusion Passenger config 활성화

```
##
# Phusion Passenger
##
# Uncomment it if you installed ruby-passenger or ruby-passenger-enterprise
##

include /etc/nginx/passenger.conf;
```

3) rails project 만들기

```
$ rails new asdf --skip-bundle
$ cd asdf
$ bundle install
```

4) Light sail 3000번 포트 열어주기

---

#### [Phusion Passenger](https://www.phusionpassenger.com/) : application client server

- ruby를 배포하는 역할 


- 음....

1) Passenger 설정

```
$ sudo vi /etc/nginx/passenger.conf
```

```
passenger_root /usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini;
passenger_ruby /home/ubuntu/.rbenv/shims/ruby;
```

3) nginx 다시 시작

```
$ sudo service nginx restart
```

2)  최종 서버 설정 : nginx와 연결

```
$ sudo vi /etc/nginx/sites-enabled/default
```

```
// 다 날리고 밑에 코드 붙여넣기 v > gg > x
// rails project 이름이 다를 경우 그 이름을 asdf에 넣기
server {
        listen 80;
        listen [::]:80 ipv6only=on;

        server_name my_domain.com;
        passenger_enabled on;
        rails_env    development;
        root         /home/ubuntu/asdf/public;

        # redirect server error pages to the static page /50x.html
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }
}
```

3) nginx restart

```
$ sudo service nginx restart
```

4)  확인

- light shail 인스턴스의 공개 IP로 들어간다.
- rails 화면 뜨면 성공




-------------

#### Docker

- AWS Docker : [AWS Elactic Container](https://aws.amazon.com/ko/ecs/)


-----

#### 참고

- rails chef cookbook : https://launchschool.com/blog/chef-basics-for-rails-developers
- code.org
  - 인터넷 구동 방법 : https://www.youtube.com/watch?v=Dxcc6ycZ73M&list=PLzdnOPI1iJNfMRZm5DDxco3UdsFegvuB7
- https://www.youtube.com/watch?v=hymzoUpM0K0



v -> shift g -> x 모두 삭제

u -> 복귀

```ruby
# index.html.erb
<h1>인스타그램!</h1>
<p>당신의 이름을 입력해주세요.</p>
<%= form_tag "/home/welcome", method: :get do%>
	<% text_field_tag :keyword%>
  	<% submit_tag :hello , remote: true %>
<%end%>
```

```ruby
$ sudo vi /etc/nginx/sites-enabled/default
server {
        listen 80;
        listen [::]:80 ipv6only=on;

        server_name my_domain.com;
        passenger_enabled on;
        rails_env    production;
        root         /home/ubuntu/my_app_name/public;

        # redirect server error pages to the static page /50x.html
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }
}
```

```ruby
$ rake secret
키를 복사해서
$ vi config/secrets.yml
맨 밑 secret_key_base 에 복붙
$ sudo service nginx restart
```

```ruby
# .gitignore 맨 하단에 추가
/config/secrets.yml
```

