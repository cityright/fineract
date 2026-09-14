# Legacy endpoint mapping

The old Flexirest classes map to the phase-one resource surface below. All
resource methods use the pinned OpenAPI operation catalog, so the HTTP verb,
path, query command, and request body remain request-compatible.

| Legacy call | Replacement |
| --- | --- |
| `Client::ListClients.all` | `client.clients.list` |
| `Client::CreateClient.create` | `client.clients.create` |
| `Client::GetClient.find` | `client.clients.retrieve(id)` |
| `Client::UpdateClient.save` | `client.clients.update(id, ...)` |
| `Client::DeleteClient.remove` | `client.clients.delete(id)` |
| `Client::ListClientAddress.all` | `client.clients.addresses.list(id)` |
| `Client::CreateAddress.create` | `client.clients.addresses.create(id, ...)` |
| `Client::UpdateAddress.save` | `client.clients.addresses.update(id, ...)` |
| `Client::RetrieveClientAccounts.find` | `client.clients.accounts(id)` |
| `Client::EntityFieldConfiguration.find` | `client.clients.field_configuration(entity)` |
| `Client::ActivateClient.create` | `client.clients.lifecycle.activate(id, ...)` |
| `Client::CloseClient.create` | `client.clients.lifecycle.close(id, ...)` |
| `Client::ReactivateClient.create` | `client.clients.lifecycle.reactivate(id, ...)` |
| `Client::RejectClient.create` | `client.clients.lifecycle.reject(id, ...)` |
| `Client::WithdrawClient.create` | `client.clients.lifecycle.withdraw(id, ...)` |
| `Client::UndoRejectClient.create` | `client.clients.lifecycle.undo_reject(id, ...)` |
| `Client::UndoWithdrawClient.create` | `client.clients.lifecycle.undo_withdraw(id, ...)` |
| `Client::AssignStaff.create` | `client.clients.assign_staff(id, staff_id: ...)` |
| `Client::UnassignStaff.create` | `client.clients.unassign_staff(id, staff_id: ...)` |
| `Client::UpdateSavingsAccount.save` | `client.clients.update_savings_account(id, savings_account_id: ...)` |
| `Client::ProposeTransfer.create` | `client.clients.transfers.propose_transfer(id, ...)` |
| `Client::AcceptTransfer.create` | `client.clients.transfers.accept_transfer(id, ...)` |
| `Client::RejectTransfer.create` | `client.clients.transfers.reject_transfer(id, ...)` |
| `Client::WithdrawTransfer.create` | `client.clients.transfers.withdraw_transfer(id, ...)` |
| `Client::ProposeAndAcceptTransfer.create` | `client.clients.transfers.propose_and_accept_transfer(id, ...)` |
| `Groups::ListGroups.all` | `client.groups.list` |
| `Groups::CreateGroup.create` | `client.groups.create` |
| `Groups::RetrieveGroup.find` | `client.groups.retrieve(id)` |
| `Groups::UpdateGroup.save` | `client.groups.update(id, ...)` |
| `Groups::DeleteGroup.remove` | `client.groups.delete(id)` |
| `Groups::RetrieveGroupTemplate.get` | `client.groups.template` |
| `Org::ListOffices.all` | `client.offices.list` |
| `Org::CreateOffice.create` | `client.offices.create` |
| `Org::RetrieveOffice.find` | `client.offices.retrieve(id)` |
| `Org::UpdateOffice.save` | `client.offices.update(id, ...)` |

The legacy login and authentication configuration classes are replaced by
`Fineract.configure`, `Fineract.client`, and the configured authentication
strategy; they are not resource endpoint operations.

## Loan servicing coverage

Loan servicing is available from `client.loans`:

| Capability | Resource methods |
| --- | --- |
| Schedules | `schedules.command`, `schedules.generate`, `schedules.reschedule` |
| Transactions | `transactions.list`, `create`, `disburse`, `repay`, `refund`, `foreclosure`, `write_off`, `recover`, `adjust` |
| Charges | `charges.list`, `create`, `pay`, `retrieve`, `update`, `delete` |
| Disbursements | `disbursements.update`, `retrieve`, `update_date` |
| Rescheduling and term variation | `reschedule`, `vary_term` |
| Delinquency | `delinquency.list`, `create`, `tags` |
| Amortization allocation | `transactions.re_amortize_preview`, `transactions.re_age_preview` |

## Accounting coverage

Primary accounting APIs are available from `client.accounting`:

| Capability | Resource methods |
| --- | --- |
| General-ledger accounts | `gl_accounts.list`, `create`, `retrieve`, `update`, `delete`, `template` |
| Accounting rules | `rules.list`, `create`, `retrieve`, `update`, `delete`, `template` |
| GL closures | `closures.list`, `create`, `retrieve`, `update`, `delete` |
| Journal entries | `journal_entries.list`, `create`, `retrieve`, `reverse`, `opening_balance`, `provisioning` |
| Accruals | `accruals.run` |
| Financial-activity mappings | `financial_activity_mappings.list`, `create`, `retrieve`, `update`, `delete` |

## Loan origination coverage

| Capability | Resource methods |
| --- | --- |
| Loan products | `client.loan_products.list`, `basic_details`, `create`, `retrieve`, `update`, `template` |
| Product mixes | `client.loan_products.product_mixes.retrieve`, `create`, `update`, `delete` |
| Applications | `client.loans.create`, `submit`, `calculate`, `retrieve`, `update`, `template` |
| Application lifecycle | `client.loans.approve`, `reject`, `withdraw`, `disburse`, `approval_template` |

## Share and transfer coverage

| Capability | Resource methods |
| --- | --- |
| Share products | `client.shares.products.list`, `create`, `retrieve`, `update`, `template`, `command` |
| Share accounts | `client.shares.accounts.list`, `create`, `retrieve`, `update`, `template`, `command`, `approve`, `activate`, `close` |
| Share dividends | `client.shares.dividends.list`, `create`, `retrieve`, `update`, `delete` |
| Account transfers | `client.account_transfers.list`, `create`, `retrieve`, `command`, `refund` |
| Transfer templates | `client.account_transfers.template`, `refund_template` |

## Reporting and discovery coverage

| Capability | Resource methods |
| --- | --- |
| Reports | `client.reporting.reports.list`, `create`, `retrieve`, `update`, `delete`, `template` |
| Run reports | `client.reporting.runner.run(name, format: :json/:csv/:pdf/:xls/:html)`, `available_exports` |
| Report mailing jobs | `client.reporting.mailing_jobs.list`, `create`, `retrieve`, `update`, `delete`, `template`, `run_history` |
| Search | `client.search.query`, `advanced`, `template` |
