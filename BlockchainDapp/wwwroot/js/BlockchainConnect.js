
async function InitializeEthereumConnection() {
    if (window.ethereum) {
        window.web3 = new Web3(ethereum);
        try {
            await ethereum.enable();
        } catch (err) {
            $('#status').html('User denied account access', err)
        }
    } else if (window.web3) {
        window.web3 = new Web3(web3.currentProvider)
    } else {
        $('#status').html('No Metamask (or other Web3 Provider) installed')
    }
}

async function CreateProduct() {

    let result = await window.ethereum.request(
        { method: 'CreateProduct' }
    );
    console.log(result);
}
