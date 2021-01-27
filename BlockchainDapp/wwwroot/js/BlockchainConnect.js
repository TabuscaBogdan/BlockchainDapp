var contractAddress = '0xAB07d4E4671D9241C190AE8252d14a98d3851283';
var contractToken;
var currentManager = "JimmyPlaceholder";
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

async function CreateProduct(productData) {

    let result = await contractToken.methods.
        CreateProduct(productData["Name"], productData["Description"],
            parseInt(productData["DEVCost"]),
            parseInt(productData["REV"]), productData["Expertise"])
        .call();
    console.log(result);
    return result
}

async function PostProduct() {
    let id = document.getElementById("ProductNameBox").value;
    let description = document.getElementById("ProductDescription").value;
    let dev = document.getElementById("ProductDEVCost").value;
    let rev = document.getElementById("ProductREV").value;
    let experitise = document.getElementById("Expertise").value;

    console.log(id + description + dev + rev + experitise);
    var data = {};
    data["Name"] = id; data["Description"] = description; data["DEVCost"] = dev; data["REV"] = rev; data["Expertise"] = experitise;

    //CreateNewProductsTable(currentManager);
    let testCall = await contractToken.methods.TestCall().call();

    let testedParameter = await contractToken.methods.TestParameter(15).call();
    console.log(testedParameter);

    var table = CreateProductsTable(currentManager);
    RenderProductsTable(table);
    var createdProduct = await CreateProduct(data)
    console.log(createdProduct);
    //AddProductToTable(table, data);
}