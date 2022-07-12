const resultTab = document.querySelector('.tab.result');
const activityTab = document.querySelector('.tab.activity');

const resultContent = document.querySelector('.result__content');
const activityContent = document.querySelector('.activity__content');

function openTab(tabName) {
    const tab = tabName === 'result' ? resultTab : activityTab;
    const content = tabName === 'result' ? resultContent : activityContent;
    const otherTab = tabName === 'result' ? activityTab : resultTab;
    const otherContent = tabName === 'result' ? activityContent : resultContent;

    tab.classList.add('open');
    otherTab.classList.remove('open');

    content.classList.remove('hide');
    otherContent.classList.add('hide');
}