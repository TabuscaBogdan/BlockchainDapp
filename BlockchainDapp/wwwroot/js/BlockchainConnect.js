var contractAddress = '0xcC1dbAd2E8d1dc8CeF7F429AbD8f6eE81ACEB4F8';
var contractToken;
async function InitializeEthereumConnection() {
    if (window.ethereum) {
        window.web3 = new Web3(window.ethereum);
        try {
            await window.ethereum.enable();
            console.log(web3.version);
            web3.eth.net.isListening()
                .then(() => console.log('is connected'))
                .catch(e => console.log('Wow. Something went wrong: ' + e));

            contractToken = new web3.eth.Contract(ABIErc20Token, contractAddress);
        } catch (err) {
            console.log('User denied account access', err);
        }
    } else if (window.web3) {
        window.web3 = new Web3(web3.currentProvider)
        contractToken = new Contract(ABIErc20Token, contractAddress);
    } else {
        console.log('No Metamask (or other Web3 Provider) installed');
    }
}

async function CreateProduct() {
    let result = await contractToken.methods.CreateProduct().call();
    console.log(result);
}
