// Replace with your canister's ID and actor reference
const canisterId = "your_canister_id_here"; // Replace with your canister ID
const actor = window.ic.actor(canisterId);

document.getElementById("addCandidateButton").addEventListener("click", async () => {
    const candidate = document.getElementById("addCandidateInput").value;
    await actor.addCandidate(candidate);
    document.getElementById("results").innerHTML = "Candidate added.";
});

document.getElementById("voteButton").addEventListener("click", async () => {
    const candidate = document.getElementById("voteInput").value;
    const result = await actor.vote(candidate);
    if ("ok" in result) {
        document.getElementById("results").innerHTML = "Vote cast.";
    } else {
        document.getElementById("results").innerHTML = "Error: " + result.err;
    }
});

document.getElementById("getVotesButton").addEventListener("click", async () => {
    const candidate = document.getElementById("getVotesInput").value;
    const result = await actor.getVotes(candidate);
    if ("ok" in result) {
        document.getElementById("results").innerHTML = "Votes for " + candidate + ": " + result.ok;
    } else {
        document.getElementById("results").innerHTML = "Error: " + result.err;
    }
});

document.getElementById("getCandidatesButton").addEventListener("click", async () => {
    const candidates = await actor.getCandidates();
    document.getElementById("results").innerHTML = "Candidates: " + candidates.join(", ");
});

document.getElementById("resetButton").addEventListener("click", async () => {
    await actor.reset();
    document.getElementById("results").innerHTML = "Voting reset.";
});
