const verificationModel = require("../models/verification.js");

async function verify(req, res) {
    const email = req.body.email_address;
    console.log(email);
    var data = await verificationModel.getStatus(email);
    if(data){
        if(data[0].verification_status == "true"){
            res.status(200);
            res.json({
                message: "Email already verified",
                status: "success"
            });
        }else{
            res.status(400);
            res.json({
                message: "Verifiy your Email First",
                status: "failed"
            });
        }
    }else{
        res.status(400);
        res.json({
            message: "User does not exist.",
            status: "failed"
        });
    }
}

// async function checkVerification(email){
//     var data = await verificationModel.getStatus(email);
//     console.log(data);
// }

module.exports.verify = verify;
