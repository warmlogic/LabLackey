LabLackey readme
====

Features to implement:
----

- Log data (subject information; experiment parameters; events like presentations, responses, etc.) to a file
  - Support for sending the log file to email or a server

- Create stimulus pool from images in a folder or words in a text file

- rename EXResponse class to something like EXTrialData

- Put stimuli in a dictionary so they can have properties. Not sure how to generalize setting properties via the config file.

- Stimulus randomization method

- Stimulus pool sub-selection method (for dividing up study and test items)

- Jitter for time durations (stimulus presentation, ISI, etc.)

- Get experiment settings from a JSON config file
  - https://github.com/stig/json-framework

- Experiment description/introduction screen after choosing an experiment.
  - This would have the back button if you didn't want to start that experiment.
  - Is it possible to only show this screen once? (depending on the type of experiment) e.g., if the experiment is still running, don't show it until the exp is done and it is run again.

Bugs to fix:
----

- Remove back button during instructions (only have it there during phase 1? or maybe have an intro screen?)


New experiment ideas:
====

- Probing for data every now and then
  - http://developer.apple.com/library/mac/#documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/IPhoneOSClientImp/IPhoneOSClientImp.html

Links:
====

Project page: https://github.com/warmlogic/LabLackey
