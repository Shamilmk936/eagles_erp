const functions = require("firebase-functions");

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

exports.sendEmailFromWeb =
functions.firestore.document("/mail/{uid}").onCreate((event, context) =>{
  console.log("==========================================");
  const html =event.data().html;
  const status =event.data().status;
  const emailList =event.data().emailList;
  console.log(" ============ transporter function =====================");
  const nodemailer =require("nodemailer");
  const transporter = nodemailer.createTransport({
    host: "smtp.zoho.com",
    port: 465,
    secure: true,
    ssl: true,
    auth: {
      user: "academy@livetosmile.in",
      pass: "Academy@1234",
    },
  });
  console.log(transporter);
  emailList.forEach(function(element) {
    const rslt = transporter.sendMail({
      from: "academy@livetosmile.in",
      to: element,
      subject: status,
      html: html,
    });
    console.log("****");
    console.log(rslt);
    return rslt;
  });
});

//token date topic


exports.scheduleClass =
functions.firestore.document("/webSchedules/{uid}").onCreate((event, context) =>{
  const axios = require("axios");

  axios({
    method: "post",
    url: "https://api.zoom.us/v2/users/livetosmiledegree@gmail.com/meetings",
    data: event.data(),
    headers: event.get('header'),
    data:event.get('data')

  }).then((res) =>{
    console.log("*******sales");
    console.log(res.data);
    if (res.data==true) {
      console.log("if true");
      db.doc("/webSchedules/"+context.params.uid)
          .update({"status": 1});
    } else {
      db.doc("/webSchedules/"+context.params.uid)
          .update({"status": 0});
    }
  })
      .catch((error) =>{
        console.error(error);
      });
});

// RAZOR PAY


exports.refund =
functions.firestore.document("/return/{uid}").onCreate((event, context) =>{

  var instance = new Razorpay({ key_id: 'rzp_live_C190kQus1hA6p6', key_secret: 'OUikvDm9Cs3PAJq6LjYaGCIOa' })

    instance.payments.refund(paymentId,{
      "amount": "1",
      "speed": "normal",
      "notes": {
        "notes_key_1": "Beam me up Scotty.",
        "notes_key_2": "Engage"
      },
      "receipt": "Receipt No. 31"
    })

});