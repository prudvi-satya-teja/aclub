const express = require('express');
const nodemailer = require('nodemailer');

var sendMail = async(receiver, subject,  message) => {
    const transporter = nodemailer.createTransport({
        service : "gmail",
        auth: {
                user: "adityauniversityclubs@gmail.com", 
                pass: "iiyg cqtg bbdf krsa"
        }
    });
    console.log()

    const mailOptions  = {
        from: "adityauniversityclubs@gmail.com",
        to: receiver,
        subject: subject,
        text: message,
    }

    await transporter.sendMail(mailOptions, (error, info) => {
        if(error) {
            return res.status(500).json(error);
        }
        return res.staus(200).json("mail send");
    }) 

};


module.exports = {
    sendMail
}