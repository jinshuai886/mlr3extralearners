install_learners("regr.lightgbm")
load_tests("regr.lightgbm")

test_that("autotest", {
  set.seed(1)
  learner = lrn("regr.lightgbm", nrounds = 50)
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("manual validation", {
  learner = lrn("regr.lightgbm", early_stopping_rounds = 1)
  task = tsk("mtcars")
  expect_error(learner$train(task))
  task$row_roles$validation = sample(seq(task$nrow), task$nrow * 0.3)
  expect_silent(learner$train(task))
})
