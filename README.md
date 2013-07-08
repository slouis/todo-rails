# Hello Todo !
todomvc.com 를 보다가 language + framework 별로 
todo 예제 소스가 있으면 좋겠다는 생각이 들어서 간단한 sample 만들고 공유 합니다. 
여기서 공유하는 코드들은 best practice는 아닙니다. 
혹시나 참여 가능 하신 분들은 yuilsang@gmail.com 으로 메일 부탁 드립니다.

## Todo

* (v) Ruby + Rails <https://github.com/dongram/todo-rails>
* (v) Scala + Play2 <https://github.com/dongram/todo-scala-play2/>
* NodeJS + CompoundJS
* Python + Django
* Java + Spring Framework
* ObjectiveC (for iOS)
* ObjectiveC (for Mac)

## How to 

todo-rails
==========

$ rake db:migrate

$ rails s

http://localhost:3000


heroku
===========
$ heroku create itodo

$ git push heroku master

$ heroku rake db:migrate
