// Replace with your deployed contract address!
const CONTRACT_ADDRESS = "YOUR_DEPLOYED_CONTRACT_ADDRESS"; 
const CONTRACT_ABI = [
    "function vote(uint _candidateId) public",
    "function addCandidate(string memory _name) public",
    "function toggleElection() public",
    "function getAllCandidates() public view returns (tuple(uint id, string name, uint voteCount)[])",
    "function electionActive() public view returns (bool)",
    "function hasVoted(address) public view returns (bool)"
];

let provider, signer, contract;

async function initWeb3() {
    if (window.ethereum) {
        // Ethers v6 Syntax
        provider = new ethers.BrowserProvider(window.ethereum);
        signer = await provider.getSigner();
        contract = new ethers.Contract(CONTRACT_ADDRESS, CONTRACT_ABI, signer);
        
        const address = await signer.getAddress();
        document.getElementById("wallet-address").innerText = `Wallet: ${address.substring(0,6)}...${address.substring(38)}`;
        return { provider, signer, contract, address };
    } else {
        Swal.fire("Error", "Please install MetaMask!", "error");
    }
}
