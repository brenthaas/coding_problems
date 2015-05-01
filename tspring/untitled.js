
var data = [
  { user: 'A', event: '1'},
  { user: 'B', event: '1'},
  { user: 'C', event: '2'},
  { user: 'A', event: '3'},
  { user: 'B', event: '4'},
  { user: 'C', event: '2'},
  { user: 'A', event: '4'},
  { user: 'B', event: '3'}
];

var sequence = [1, 3, 4];

var a = function(events, sequence) {
  var users = {};
  var matching_users = [];
  for(var i = 0; i < events.length, i++){
    var user = event[i].user;
    var current_num = event[i].event;

    if(!users[user]){
      users[user] = 0;
    }
    if(users[user] < events.length && sequence[users[user]] == current_num){
      users[user]++;
    }
    if(users[user] == sequence.length){
      matching_users.push(user);
    }
  }
  return matching_users;
}


def a(events, sequence)

  events.each do |event|
    user = event['user']
    current_num = event['event']
    users[user] ||= 0
    if users[user] < events.length && sequence[users[user]] == current_num
      users[user] += 1
    end
    users.reduce{ |k,v| v == events.length }.keys
  end
end
