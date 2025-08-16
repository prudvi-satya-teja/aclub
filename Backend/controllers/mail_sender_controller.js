const express = require("express");
const nodemailer = require("nodemailer");

var sendMail = async (receiver, subject, message) => {
    const transporter = nodemailer.createTransport({
        service: "gmail",
        auth: {
            user: "adityauniversityclubs@gmail.com",
            pass: "bsig rwqe mbfj gmtb",
        },
    });
    console.log("hello");

    const mailOptions = {
        from: "adityauniversityclubs@gmail.com",
        to: receiver,
        subject: subject,
        text: message,
    };

    await transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
            // return res.status(500).json(error);
            console.log(error);
            return error;
        }
        // return res.staus(200).json("mail send");
        console.log("mail send successful");
        return "mail send";
    });
};

module.exports = {
    sendMail,
};
