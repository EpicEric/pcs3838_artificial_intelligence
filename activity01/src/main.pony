actor Main
  new create(env: Env) =>
    try
      env.out.print(BidirectionalSearch(InitialState(), FinalState())()?)
    else
      env.out.print("Could not find a path!")
    end
