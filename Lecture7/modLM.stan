data {
  int<lower=0> nObs;          // No. obs.
  vector<lower=0>[nObs] BM;   // biomass observations
  vector<lower=0>[nObs] terpenes;
  real<lower=0> aMean;       // mean of prior alpha
  real<lower=0> aSD;         // SD of prior alpha
  real<lower=0> bSD;          // SD of prior beta
  real<lower=0> sigmaSD;      // scale for sigma
}

parameters {
  real alpha;
  real beta;
  real<lower=0> sigma;
}

transformed parameters {
  // can be useful for plotting purposes
  vector[nObs] mu;
  mu = alpha + beta*terpenes;
}

model {
  alpha ~ normal(aMean, aSD);
  beta ~  normal(0, bSD);
  sigma ~ cauchy(0, sigmaSD);

  BM ~ normal(mu, sigma);
}

