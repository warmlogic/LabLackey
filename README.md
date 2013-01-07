LabLackey readme
====

Purpose
----

LabLackey is an iOS-based framework for running psychology experiments. Currently it has one experimental paradigm implemented, which tests recognition memory. The framework was designed to accommodate multiple tasks, and there are plans to implement both other stimulus--response paradigms (e.g., the Stroop task) as well as experiments to collect behavioral measures in other ways (e.g., probe with a question every so often and log the response, such as, "Were you just daydreaming?"). Experiments will be designed with end-user configuration in mind.

How to use LabLackey
----

- The app currently runs in Xcode's iOS simulator (a developer account is needed to load it onto an iOS device).
  - It has been tested with Xcode 4.5.2 as an iPhone app under iOS 6.
- Once the repository is cloned to your local computer, you will see that the actual project itself is currently named `Exp`.
- A JSON-formatted configuration file is needed to run an experiment. A basic default configuration file is located at `LabLackey/Exp/config.json`.
  - Upon running, the app expects to find this configuration file in the iTunes File Sharing "Documents" directory for this app (`~/Library/Application Support/iPhone Simulator/6.0/Applications/[GUID]/Documents/config.json`). However, we're not actually using iTunes File Sharing yet (i.e., we're not running on an iOS device), and this directory won't exist until after the initial compilation. Thus, if it doesn't find `Documents/config.json` upon running, it will instead use the basic default configuration file.
  - NB: JSON files do not seem to be able to contain comments.
- To run the app, open `Exp.proj` in Xcode and click the "Run" button at the top left.
  - Then choose an experiment to participate in.
  - Logged experiment data currently gets saved to a CSV file in `~/Library/Application Support/iPhone Simulator/6.0/Applications/[GUID]/Documents/[Experiment name]/`

Current features:
----

- Experiment configuration
  - Initial support for having multiple types of experiments.
  - Full support for reading experiment parameters from a JSON file.
    - NB: The config file goes in the app's iTunes File Sharing `Documents` directory (see above). It must be named `config.json`. See `LabLackey/Exp/config.json` for a basic default configuration.
    - JSON-related resources:
      - http://json.org
      - http://developer.apple.com/library/ios/#documentation/Foundation/Reference/NSJSONSerialization_Class/Reference/Reference.html

- Stimuli
  - Construct stimulus pool from images in a folder (hard coded)
  - Parameters for study and test phase trials (set in `config.json`)
  - Stimulus array randomization
  - Sub-selection for study and test phases.
    - The number of old/studied stimuli to show during test is hard coded at the time of compilation as the variable `_numberToTransferFromStudyToTest` in `EXExperiment.m`.
      - This is because I haven't completely decided how I want to handle this "transfer".

- Trial presentation
  - Random jitter for time durations (fixation, ISI, and stimulus presentation)
    - Uses `arc4random_uniform(upper_bound)`
      - e.g., http://stackoverflow.com/questions/160890/generating-random-numbers-in-objective-c

- Log data
  - response
  - reaction time
  - write to a CSV file


Features to implement:
----

- Experiment configuration
  - Use *type* `key:value` in `config.json` to configure specific types of experiments.
  - Handle additional configuration files for when an experimenter wants to provide participants with a separate `config.json` file.

- Stimuli
  - Create stimulus pool from words in a text file
  - Stimulus metadata
    - e.g., set particular presentation parameters, or know whether a stimulus is old or new (specific to recognition memory experiment)

- Log data
  - Log other types of data
    - subject information (need some kind of unique identifier)
    - experiment parameters (maybe write the experiment array from `config.json` to its own file)
    - stimulus presentations for study and test
    - trial/event type (e.g., `STUDY_PRESENTATION`, `TEST_RESPONSE`)
  - Support for exporting the log file via email or uploading to a server

- GUI/Visual presentation
  - Initial experiment description/introduction screen.
    - This would have the "Back" button in case you didn't want to start that experiment.
    - Then the "Back" button should be removed from any phase instruction screen.


Other experimental paradigm ideas:
====

- Probe for data every now and then via local notifications
  - http://developer.apple.com/library/mac/#documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/IPhoneOSClientImp/IPhoneOSClientImp.html


Links:
====

Project page: https://github.com/warmlogic/LabLackey

[![githalytics.com alpha](https://cruel-carlota.pagodabox.com/23629df4d2671acbd34464795b84c344 "githalytics.com")](http://githalytics.com/warmlogic/LabLackey)
