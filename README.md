LabLackey readme
====

Current features:
----

- Stimuli
  - Construct stimulus pool from images in a folder (hard coded)
  - Parameters for number of study and test phase trials (hard coded)
  - Stimulus array randomization
  - Sub-selection for study and test phases

- Trial presentation
  - Random jitter for time durations (fixation, ISI, and stimulus presentation) using arc4random_uniform(upper_bound), as seen here http://stackoverflow.com/questions/160890/generating-random-numbers-in-objective-c

- Log data
  - response
  - reaction time
  - write to a file


Features to implement:
----

- Experiment configuration
  - Read parameters from a JSON configuration file
    - http://json.org
    - http://developer.apple.com/library/ios/#documentation/Foundation/Reference/NSJSONSerialization_Class/Reference/Reference.html
      - +(id) JSONObjectWithData: (NSData *)data initWithContentsOfFile: (NSString *)path;
    - https://github.com/stig/json-framework

- Stimuli
  - Create stimulus pool from words in a text file

- Log data
  - subject information
  - experiment parameters
  - stimulus presentations for study and test
  - trial/event type (e.g., STUDY_PRESENTATION, TEST_RESPONSE)
  - Support for sending the log file to email or a server

- Visual presentation
  - Experiment description or introduction screen after choosing an experiment.
    - This would have the "Back" button if you didn't want to start that experiment.


Other experiment paradigm ideas:
====

- Probe for data every now and then via local notifications
  - http://developer.apple.com/library/mac/#documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/IPhoneOSClientImp/IPhoneOSClientImp.html


Links:
====

Project page: https://github.com/warmlogic/LabLackey
