const bcrypt = require('bcryptjs');

let encrypt = {};

encrypt.hashPassword =  async function (plaintextPassword) {
    return await bcrypt.hash(plaintextPassword, 10);
}

encrypt.comparePassword = async function (plaintextPassword, hash) {
    const result = await bcrypt.compare(plaintextPassword, hash);
    return result;
}

module.exports = encrypt;