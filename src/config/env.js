import 'dotenv/config';

function requireVar(name) {
    const val = process.env[name];
    if (!val) throw new Error(`Missing required env: ${nmae}`);
    return val;
}
export const cfg = {
  env: process.env.NODE_ENV || 'development',
  port: Number(process.env.PORT || 5050), // updated default
  baseUrl: process.env.BASE_URL || `http://localhost:${process.env.PORT || 5050}`,
  frontendOrigin: process.env.FRONTEND_ORIGIN || `http://localhost:${process.env.PORT || 5050}`,
  paystackSecret: requireVar('PAYSTACK_SECRET_KEY'),
  paystackApi: 'https://api.paystack.co',
  dbUrl: requireVar('DATABASE_URL')
};