import 'package:flutter/material.dart';

///add [WidgetsBinding.instance.addOberver] in your initState of root page and [WidgetsBinding.instance.addOberver] in your dispose of root page, 
///you should [ObserverGlobals.ob] put in [WidgetsBinding.instance.addOberver] and [WidgetsBinding.instance.addOberver] as a parameter.
class ObserverGlobals {
  // Singleton instance
  static final ObserverGlobals _instance = ObserverGlobals._internal();

  ///oberver instance
  Observer? ob;
  ///add a observer listener
  addListener(){
    if(ob==null){
    ob=Observer(appState: (appState){
      emit('appState',appState);
    });
    WidgetsBinding.instance.addObserver(ob!);
    }
  }
  ///remove a observer listener
  removeListener(){
    if(ob!=null){
      WidgetsBinding.instance.removeObserver(ob!);
    }
  }
  

  factory ObserverGlobals() { 
    return _instance;
  }

  ObserverGlobals._internal();

  // A map to hold the callbacks
  final Map<String, List<Function(bool)>> _listeners = {};

  // Register a callback for a specific event
  void on(String event, Function(bool) callback) {
    if (_listeners[event] == null) {
      _listeners[event] = [];
    }
    _listeners[event]!.add(callback);
  }

  // Unregister a callback for a specific event
  void off(String event, Function(bool) callback) {
    _listeners[event]?.remove(callback);
  }

  // Notify all listeners of a specific event
  void emit(String event,bool appState) {
    _listeners[event]?.forEach((callback) => callback(appState));
  }



  
}

class Observer extends WidgetsBindingObserver {
  Function(bool) appState;
  Observer({
    required this.appState
  });

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // 处理应用生命周期状态变化
    if (state == AppLifecycleState.resumed) {
      appState(true);
    } else if (state == AppLifecycleState.paused) {
      appState(false);
    }
  }
}

