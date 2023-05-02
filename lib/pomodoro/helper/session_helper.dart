enum Session { working, shortBreak, longBreak }

const Map<Session, String> sessionToNameMap = {
  Session.working: 'Working',
  Session.shortBreak: 'Short Break',
  Session.longBreak: 'Long Break',
};

const Map<Session, String> sessionToSayingMap = {
  Session.working: 'Stay focused for the working session',
  Session.shortBreak: 'Take a short break',
  Session.longBreak: 'Take a long break',
};
