const express = require('express');
const nodemailer = require('nodemailer');

var sendMail = async() => {
    const transporter = nodemailer.createTransport({
        service : "gmail",
        auth: {
                user: "adityauniversityclubs@gmail.com", 
                pass: "nsab onqb jtqc czat"
        }
    });

    const mailOptions  = {
        from: "prudvisatyateja1234@gmail.com",
        to: "22a91a0536@aec.edu.in",
        subject: "hello coder",
        text: "hello Code36",
    }

    await transporter.sendMail(mailOptions, (error, info) => {
        if(error) {
            return res.status(500).json(error);
        }
        return res.staus(200).json("mail send");
    }) 

};
