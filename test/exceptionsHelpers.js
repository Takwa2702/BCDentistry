// Helper function to catch revert exceptions
async function catchRevert(promise) {
    try {
        await promise;
        assert.fail("Expected revert not received");
    } catch (error) {
        const revertFound = error.message.search("revert") >= 0;
        assert(revertFound, `Expected "revert," but got ${error} instead`);
    }
}

module.exports = {
    catchRevert,
};
