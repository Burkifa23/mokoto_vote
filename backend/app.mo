actor Voting {
  type Candidate = Text;
  type VoteCount = Nat;

  var candidates : [Candidate] = [];
  var votes : HashMap.HashMap<Candidate, VoteCount> = HashMap.HashMap.fromIter([]);

  public func addCandidate(candidate : Candidate) : async () {
    if (!candidates.contains(candidate)) {
      candidates.append(candidate);
      votes.put(candidate, 0);
    };
  };

  public func vote(candidate : Candidate) : async Result.Result<(), Text> {
    if (!candidates.contains(candidate)) {
      return Result.Result.err("Candidate not found");
    };
    let currentVotes = votes.get(candidate);
    switch (currentVotes) {
      case (?count) {
        votes.put(candidate, count + 1);
        return Result.Result.ok(());
      };
      case null {
        return Result.Result.err("Internal error: Candidate vote count not initialized");
      };
    };
  };

  public func getVotes(candidate : Candidate) : async Result.Result<VoteCount, Text> {
    if (!candidates.contains(candidate)) {
      return Result.Result.err("Candidate not found");
    };
    let currentVotes = votes.get(candidate);
    switch (currentVotes) {
      case (?count) {
        return Result.Result.ok(count);
      };
      case null {
        return Result.Result.err("Internal error: Candidate vote count not initialized");
      };
    };
  };

  public func getCandidates() : async [Candidate] {
    return candidates;
  };

  public func reset() : async () {
    candidates := [];
    votes := HashMap.HashMap.fromIter([]);
  };

};
