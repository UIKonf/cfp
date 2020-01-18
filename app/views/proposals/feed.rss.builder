xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0' do
  xml.channel do
    xml.title 'UIKonf Call for Proposals'
    xml.description 'UIKonf 2020 - May 17th to 20th - Call for Proposal'
    xml.link proposals_url

    @proposals.each do |proposal|
      xml.item do
        xml.title proposal.title
        xml.description do
          xml.cdata! markdown proposal.description
        end
        xml.pubDate proposal.created_at.to_s(:rfc822)
        xml.link proposal_url(proposal)
        xml.guid proposal_url(proposal)
      end
    end
  end
end
